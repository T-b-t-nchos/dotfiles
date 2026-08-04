return {
    {
        "esmuellert/codediff.nvim",
        cmd = "CodeDiff",
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewToggleFiles" },
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
        },
        dependencies = { },
        config = function()

        end,
    },
    {
        'isakbm/gitgraph.nvim',
        module = "gitgraph",
        cmd = "GitGraph",
        keys = {
            { "<leader>gl", function() require("gitgraph").draw({}, { all = true, max_count = 5000 }) end, desc = "Open GitGraph" },
        },
        opts = {
            git_cmd = "git",
            symbols = {
                merge_commit = 'M',
                commit = '*',
            },
            format = {
                timestamp = '%H:%M:%S %d-%m-%Y',
                fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
            },
            hooks = {
                on_select_commit = function(commit)
                    print('selected commit:', commit.hash)
                end,
                on_select_range_commit = function(from, to)
                    print('selected range:', from.hash, to.hash)
                end,
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = {"BufRead","BufNewFile"},
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
        keys = {
            { "<leader>gg", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
        },
        dependencies = { "nvim-lua/plenary.nvim" },
        init = function()

        end,
    },
    {
        "pwntester/octo.nvim",
        cmd = "Octo",
        keys = {
            { "<leader>oil", "<cmd>Octo issue list<CR>", desc = "Issue List" },
            { "<leader>oie", "<cmd>Octo issue edit<CR>", desc = "Issue Edit" },
            { "<leader>oic", "<cmd>Octo issue close<CR>", desc = "Issue Close" },
            { "<leader>oib", "<cmd>Octo issue browser<CR>", desc = "Issue Browser" },
            { "<leader>oin", "<cmd>Octo issue create<CR>", desc = "Issue Create" },

            { "<leader>opl", "<cmd>Octo pr list<CR>", desc = "PR List" },
            { "<leader>ope", "<cmd>Octo pr edit<CR>", desc = "PR Edit" },
            { "<leader>opc", "<cmd>Octo pr close<CR>", desc = "PR Close" },
            { "<leader>opb", "<cmd>Octo pr browser<CR>", desc = "PR Browser" },
            {
                "<leader>opn",
                function ()
                    vim.cmd("Octo pr create")
                    vim.cmd("Octo pr draft")
                end, desc = "PR Draft"
            },
        },

        opts = {
            -- or "fzf-lua" or "snacks" or "default"
            picker = "telescope",
            -- bare Octo command opens picker of commands
            enable_builtin = true,
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            -- OR "ibhagwan/fzf-lua",
            -- OR "folke/snacks.nvim",
            "nvim-tree/nvim-web-devicons",
        },
    },
}
