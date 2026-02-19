return {
  {
    "nvim-treesitter/nvim-treesitter",
    --event = { "BufNewFile", "BufRead"},
    lazy = false,
    build = ':TSUpdate',
    config = function()
        -- ...
    end,
    opts = {
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
