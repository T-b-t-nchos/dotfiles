return {
    'nvim-telescope/telescope.nvim', version = '*',
    cmd = "Telescope",
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = vim.fn.executable("make") == 1 and "make" or nil,
        },
    }
}
