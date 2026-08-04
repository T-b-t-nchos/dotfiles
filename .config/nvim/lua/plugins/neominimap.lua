return {
    "Isrothy/neominimap.nvim",
    cmd = "Neominimap",
    keys = {
        {
            "<leader>nm",
            "<cmd>Neominimap Toggle<CR>",
            desc = "Neominimap",
        },
    },
    init = function()
        vim.opt.wrap = false
        vim.opt.sidescrolloff = 36

        vim.g.neominimap = {
            auto_enable = false,
        }
    end,
}
