return {
    "folke/which-key.nvim",
    event = "UIEnter",
    config = function()
        require("which-key").setup({
            win = {
                border = "rounded",
            },
            spec = {
                {
                    mode = "n",
                    { "<leader>b", group = "Buffers" },
                    { "<leader>c", group = "Colors" },
                    { "<leader>f", group = "Fuzzy Finder" },
                    { "<leader>g", group = "Git" },
                    { "<leader>i", group = "Images" },
                    { "<leader>L", group = "(Lua/La)TeX" },
                    { "<leader>n", group = "Navigation" },
                    { "<leader>o", group = "GitHub (Octo)" },
                    { "<leader>p", group = "Previews" },
                    { "<leader>S", group = "Setsu." },
                    { "<leader>w", group = "Windows" },
                    { "<leader>x", group = "LSP" },
                    { "<leader>#", group = "C#/.NET" },
                    { "<leader><tab>", group = "tabs" },
                },
            },
        })

        local wk = require("which-key")
    end,
}

