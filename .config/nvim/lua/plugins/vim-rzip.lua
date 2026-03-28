return {
    "lbrayner/vim-rzip",
    ft = { "zip" },
    init = function()
        vim.cmd.runtime("plugin/zipPlugin.vim")
    end,
}
