vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "BufFilePost" }, {
    group = vim.api.nvim_create_augroup("clang-format", { clear = true }),
    callback = function(args)
        require("clang-format").config(args.buf)
    end,
})
