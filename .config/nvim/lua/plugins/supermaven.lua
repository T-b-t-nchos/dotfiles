return {
    "supermaven-inc/supermaven-nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "SupermavenUseFree", "SupermavenStart", "SupermavenToggle" },

    config = function()
        require("supermaven-nvim").setup({
            keymaps = {
                accept_suggestion = nil,
                accept_word = nil,
                clear_suggestion = "<C-e>",
            },
        })

        if not vim.g.supermaven_free_done then
            vim.schedule(function()
                pcall(vim.cmd, "SuperMavenUseFree")
            end)
            vim.g.supermaven_free_done = true
        end
    end,
}
