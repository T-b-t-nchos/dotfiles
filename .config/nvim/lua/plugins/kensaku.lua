return {
    {
        "lambdalisue/vim-kensaku",
        lazy = true,
        dependencies = { "vim-denops/denops.vim" },
    },
    {
        "lambdalisue/kensaku-command.vim",
        lazy = true,
        cmd = { "Kensaku" },
        dependencies = { "lambdalisue/vim-kensaku" },
    },
    {
        "lambdalisue/vim-kensaku-search",
        -- event = "CmdlineEnter",
        event = "VeryLazy",
        keys = {
            {
                "<CR>",
                "<Plug>(kensaku-search-replace)<CR>",
                mode = "c",
            },
        },
        dependencies = {
            "lambdalisue/vim-kensaku",
            "vim-denops/denops.vim",
        },
    }
}
