local mason_registry = require "mason-registry"
local Job = require "plenary.job"
local fmt = string.format

local properties = {}

function properties.use_tab(bufnr, val)
    vim.bo[bufnr].expandtab = (val == "Never")
end

function properties.indent_width(bufnr, val)
    local n = tonumber(val) or error("IndentWidth: must be a number", 0)
    vim.bo[bufnr].shiftwidth = n
    vim.bo[bufnr].softtabstop = n
    vim.bo[bufnr].tabstop = n
end

local function parse_line(line)
    if line:match "^%s*//" then
        return
    end
    if line:match "^%s*/%*" then
        return
    end
    local value = line:match "^%s*UseTab:%s*(.*)%s*$"
    if value then
        return 'use_tab', value
    end
    value = line:match "^%s*IndentWidth:%s*(.*)%s*$"
    if value then
        return 'indent_width', value
    end
end

local function parse(file)
    local opts = {}
    local f = io.open(file)
    if f then
        for line in f:lines() do
            local key, value = parse_line(line)
            if key ~= nil and value ~= nil then
                opts[key] = value
            end
        end
        f:close()
    end
    return opts
end


local function config(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) then
        return
    end

    local path = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))
    if vim.bo[bufnr].buftype ~= "" or not vim.bo[bufnr].modifiable or path == "" then
        return
    end

    local dot_clang_format = vim.fs.find(".clang-format", {
        upward = true,
        stop = vim.fs.dirname(vim.uv.cwd()),
        path = vim.fs.dirname(path),
    })
    if vim.tbl_isempty(dot_clang_format) then
        return
    end

    local applied = {}
    for opt, val in pairs(parse(dot_clang_format[1])) do
        local func = properties[opt]
        if func then
            local ok, err = pcall(func, bufnr, val)
            if ok then
                applied[opt] = val
            else
                vim.notify(fmt("clang-format: invalid value for option %s: %s. %s", opt, val, err),
                    vim.log.levels.WARN, {
                    title = 'clang-format',
                })
            end
        end
    end
    vim.b[bufnr].clang_format = applied
end

local function get_clang_format_bin()
    local pkg = mason_registry.get_package "clang-format"
    return pkg:get_install_path() .. "/venv/bin/clang-format"
end

local function format(line_start, line_end)
    local buffer_text = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    local arguments = {}
    if line_start ~= nil and line_end ~= nil then
        vim.list_extend(arguments, { "-lines", string.format("%d:%d", line_start, line_end) })
    end
    local fp = vim.api.nvim_buf_get_name(0)
    if fp ~= nil then
        vim.list_extend(arguments, { "-assume-filename", fp })
    end

    local pos = vim.api.nvim_win_get_cursor(0)
    local cursor_byte = vim.api.nvim_buf_get_offset(0, pos[1] - 1)
    cursor_byte = cursor_byte + pos[2]
    if cursor_byte < 0 then
        print "Couldn't determine cursor position. Is your file empty?"
        return
    end
    vim.list_extend(arguments, { "-cursor", cursor_byte })

    local stderr = {}
    local header
    local contents = {}
    local job = Job:new {
        command = get_clang_format_bin(),
        args = arguments,
        writer = buffer_text,
        on_stdout = function(_, data)
            if header == nil then
                header = vim.json.decode(data)
            else
                table.insert(contents, data)
            end
        end,
        on_stderr = function(_, data)
            table.insert(stderr, data)
        end,
    }

    job:sync()

    if not vim.tbl_isempty(stderr) then
        -- XXX(andrea): this should probably be better to print as a single string.
        -- XXX(andrea): should we use vim.notify?
        vim.pretty_print(stderr)
    end

    if header == nil then
        vim.notify [[No output from clang-format (crashed?).
                 Please report to bugs.llvm.org.]]
        return
    end

    -- we need the hunks in reverse order in order to apply them, so instead of let vim.diff
    -- return then hunks directly pass the callback to insert them ourselves inserting new
    -- hunks always in the first position.
    local hunks = {}
    local original = table.concat(buffer_text, "\n")
    local formatted = table.concat(contents, "\n")
    vim.diff(original, formatted, {
        on_hunk = function(sa, ca, sb, cb)
            table.insert(hunks, 1, { sa, ca, sb, cb })
        end,
        result_type = "indices",
    })
    for _, hunk in ipairs(hunks) do
        local sa, ca, sb, cb = unpack(hunk)
        local replacement = {}
        for i = sb, sb + cb - 1 do
            table.insert(replacement, contents[i])
        end
        -- apparently when the source has `0` as "count" it means that some lines
        -- should be added *after* the "source" line but the `nvim_buf_set_lines`
        -- when using `start` and `end` as the same value will add them in that
        -- exact line so just bump it by 1.
        -- XXX(andrea): still not totally proven... play with it some more.
        if ca == 0 then
            sa = sa + 1
        end
        vim.api.nvim_buf_set_lines(0, sa - 1, sa - 1 + ca, false, replacement)
    end
    if header.IncompleteFormat then
        vim.notify "clang-format: incomplete (syntax errors)"
    end

    -- Convert cursor bytes to (line, col)
    -- Don't use goto: https://github.com/vim/vim/issues/5930
    local new_cursor_byte = tonumber(header.Cursor)
    local row = 0
    local line_byte = 0
    while true do
        local b = vim.api.nvim_buf_get_offset(0, row + 1)
        if b > new_cursor_byte then
            break
        end
        line_byte = b
        row = row + 1
    end
    local col = new_cursor_byte - line_byte
    vim.api.nvim_win_set_cursor(0, { row + 1, col })
end

return {
    format = format,
    config = config,
}
