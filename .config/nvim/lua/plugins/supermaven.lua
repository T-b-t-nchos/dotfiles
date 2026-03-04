return {
    "supermaven-inc/supermaven-nvim",
    event = { "BufReadPost", "BufNewFile" },

    build = function()
        vim.cmd("SupermavenUseFree")
    end,

    config = function()
        require("supermaven-nvim").setup({})
    end,
}
