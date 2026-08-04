return {
    {
        'nvim-telescope/telescope.nvim', version = '*',
        -- cmd = "Telescope",
        event = "VeryLazy",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
            { "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
            { "<leader>fd", "<cmd>Telescope find_files cwd_only=true<cr>", desc = "Find File in cwd" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>fn", "<cmd>Telescope nerdy<cr>", desc = "Nerdy" },
            { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
            { "<leader>fv", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
            { "<leader>fr", "<cmd>Telescope registers<cr>", desc = "Registers" },
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function ()
            require('telescope').setup({
                defaults = {
                    file_ignore_patterns = {
                        "%.env",
                        "yarn.lock",
                        "package%-lock.json",
                        "lazy%-lock.json",
                        "init.sql",

                        "node_modules/.*",
                        "target/.*",
                        ".git/.*",
                        ".vs/.*",

                        "node_modules%\\.*",
                        "target%\\.*",
                        ".git\\.*",
                        ".vs\\.*",
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        no_ignore = true,
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                    file_browser = {
                        -- theme = "ivy",
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        mappings = {
                            ["i"] = {
                                -- your custom insert mode mappings
                            },
                            ["n"] = {
                                -- your custom normal mode mappings
                            },
                        },
                    },
                }
            })

            require("telescope").load_extension("dir")
            require('telescope').load_extension("fzf")
            require("telescope").load_extension("file_browser")
            require('telescope').load_extension('gh')
            require('telescope').load_extension('nerdy')
        end
    },
    {
        "princejoogie/dir-telescope.nvim",
        lazy = true,
        cmd = "FileInDirectory",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {},
        config = function(_, opts)
            require("dir-telescope").setup(opts)
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = true,
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        lazy = true,
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install"
    },
    {
        'nvim-telescope/telescope-github.nvim',
        lazy = true,
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim',
        }
    },
}
