return {
    "akinsho/toggleterm.nvim",
    --event = "VeryLazy",
    cmd = "ToggleTerm",
    keys = {
        {
            "<C-\\>",
            "<cmd>ToggleTerm<CR>",
            mode = { "n", "i", "t" },
            desc = "Toggle Terminal",
        },
    },
    version = "*",
    config = function()
        require("toggleterm").setup({
            shell = "pwsh",
            --open_mapping = [[<C-\>]],
            direction = "horizontal",
            size = 10,
            shade_terminals = true,
            start_in_insert = true,
            persist_size = true,
        })
    end,
}
