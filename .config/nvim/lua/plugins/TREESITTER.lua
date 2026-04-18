return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = true,
        build = ':TSUpdate',
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "cs",
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
        config = function()
            local ts = require("nvim-treesitter")
            ts.install({
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
            })
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
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufNewFile", "BufRead" },
        opts = {
            -- ...
        },
    },
}
