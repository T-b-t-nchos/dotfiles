return {
    'nemanjamalesija/smart-paste.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function ()
        require('smart-paste').setup({
            exclude_filetypes = {},
        })
    end,
}
