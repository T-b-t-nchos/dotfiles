return {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true,
    build = vim.fn.executable("make") == 1 and "make" or nil,
}
