return {
    {
        "romus204/tree-sitter-manager.nvim",
        lazy = true,
        cmd = "TSManager",
        event = { "BufNewFile", "BufRead" },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "cs",
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
        config = function()
            require("tree-sitter-manager").setup({
                ensure_installed = {
                    -- Desktop-App
                    "bash",
                    "c_sharp",
                    "java",
                    "lua",
                    "powershell",
                    "python",
                    "ruby",

                    -- Documents
                    "csv",
                    "diff",
                    "markdown",
                    "markdown_inline",

                    -- Web
                    "html",
                    "css",
                    "php",
                    "javascript",
                    "typescript",

                    -- Build / config
                    "git_config",
                    "gitattributes",
                    "gitcommit",
                    "gitignore",
                    "toml",
                    "yaml",

                    -- Other
                    "json",
                    "json5",
                    "xml",
                },
                auto_install = true,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = true,
        build = ':TSUpdate',
        init = function()
            -- vim.api.nvim_create_autocmd("FileType", {
            --     pattern = "cs",
            --     callback = function(args)
                --         pcall(vim.treesitter.start, args.buf)
                --     end,
                -- })
            end,
            config = function()
                -- local ts = require("nvim-treesitter")
                -- ts.install({
                --     -- Desktop-App
                --     "bash",
                --     "c_sharp",
                --     "java",
                --     "lua",
                --     "powershell",
                --     "python",
                --     "ruby",
                --
                --     -- Documents
                --     "csv",
                --     "diff",
                --     "markdown",
                --     "markdown_inline",
                --
                --     -- Web
                --     "html",
                --     "css",
                --     "php",
                --     "javascript",
                --     "typescript",
                --
                --     -- Build / config
                --     "git_config",
                --     "gitattributes",
                --     "gitcommit",
                --     "gitignore",
                --     "toml",
                --     "yaml",
                --
                --     -- Other
                --     "json",
                --     "json5",
                --     "xml",
                -- })
        end,
        opts = {
            ensure_installed = {
            },
            highlight = {
                enable = true,
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "romus204/tree-sitter-manager.nvim" },
        event = { "BufNewFile", "BufRead" },
        opts = {
            -- ...
        },
    },
}
