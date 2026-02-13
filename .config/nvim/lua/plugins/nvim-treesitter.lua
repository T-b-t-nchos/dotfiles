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
            "c_sharp",
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
