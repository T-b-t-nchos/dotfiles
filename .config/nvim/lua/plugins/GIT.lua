return {
    {
        "esmuellert/codediff.nvim",
        cmd = "CodeDiff",
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewToggleFiles" },
        dependencies = { },
        config = function()

        end,
    },
    {
        'isakbm/gitgraph.nvim',
        module = "gitgraph",
        cmd = "GitGraph",
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
        dependencies = { "nvim-lua/plenary.nvim" },
        init = function()

        end,
    },
    {
        "pwntester/octo.nvim",
        cmd = "Octo",
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
