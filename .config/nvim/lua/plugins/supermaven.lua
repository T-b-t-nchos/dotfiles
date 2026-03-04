return {
    "supermaven-inc/supermaven-nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "SupermavenUseFree", "SupermavenStart", "SupermavenToggle" },

    build = function()
        vim.cmd("SupermavenUseFree")
    end,

    config = function()
        require("supermaven-nvim").setup({})
    end,
}
