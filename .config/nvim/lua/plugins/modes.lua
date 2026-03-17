return {
    "mvllow/modes.nvim",
    lazy = false,
    config = function()
        require('modes').setup({
                ignore = { "neo-tree", "TelescopePrompt", "!minifiles" }
            })
        end
    }

