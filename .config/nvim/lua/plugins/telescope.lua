return {
    'nvim-telescope/telescope.nvim', version = '*',
    cmd = "Telescope",
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = vim.fn.executable("make") == 1 and "make" or nil,
        },
    },
    config = function ()
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = {
                    "node_modules/.*",
                    "%.env",
                    "yarn.lock",
                    "package%-lock.json",
                    "lazy%-lock.json",
                    "init.sql",
                    "target/.*",
                    ".git/.*",
                },
            },
        })
    end
}
