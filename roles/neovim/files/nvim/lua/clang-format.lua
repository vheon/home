local mason_registry = require "mason-registry"
local Job = require "plenary.job"

local function get_clang_format_bin()
    local pkg = mason_registry.get_package "clang-format"
    return pkg:get_install_path() .. "/venv/bin/clang-format"
end

local M = {}

function M.format(line_start, line_end)
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

return M
