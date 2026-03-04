return {
    "supermaven-inc/supermaven-nvim",
    event = { "BufReadPost", "BufNewFile" },

    build = function()
        vim.cmd("SuperMavenUseFree")
    end,

    config = function()
        require("supermaven-nvim").setup({})
    end,
}
