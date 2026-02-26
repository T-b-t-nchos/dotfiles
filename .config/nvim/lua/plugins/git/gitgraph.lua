return{
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
}
