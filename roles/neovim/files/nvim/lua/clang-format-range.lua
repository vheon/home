local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local RANGE_FORMATTING = methods.internal.RANGE_FORMATTING

return h.make_builtin({
    name = "clang_format_range",
    meta = {
        url = "https://www.kernel.org/doc/html/latest/process/clang-format.html",
        description = "Tool to format C/C++/… code according to a set of rules and heuristics.",
    },
    method = RANGE_FORMATTING,
    filetypes = { "c", "cpp" },
    generator_opts = {
        command = "clang-format",
        args = h.range_formatting_args_factory({
            "-assume-filename", "$FILENAME",
        }, "--lines", nil, { use_rows = true, delimiter = ":" }),
        to_stdin = true,
    },
    factory = h.formatter_factory,
    -- factory = function(opts)
    --   opts.ignore_stderr = true
    --   if opts.to_temp_file then
    --     opts.from_temp_file = true
    --   end

    --   opts.on_output = function(params, done)
    --     local output = params.output
    --     if not output then
    --       return done()
    --     end

    --     print(vim.inspect(output))

    --     return done({ { text = output } })
    --   end
    -- end
})
