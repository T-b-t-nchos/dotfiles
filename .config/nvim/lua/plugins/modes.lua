return {
    "mvllow/modes.nvim",
    event = "BufRead",
    config = function()
        require('modes').setup({
                ignore = { "neo-tree", "TelescopePrompt", "!minifiles" }
            })
        end
    }

