return {
    "Isrothy/neominimap.nvim",
    cmd = "Neominimap",
    init = function()
        vim.opt.wrap = false
        vim.opt.sidescrolloff = 36

        vim.g.neominimap = {
            auto_enable = false,
        }
    end,
}
