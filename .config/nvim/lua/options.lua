vim.opt.number = true
vim.opt.hlsearch = true
vim.opt.smartindent = true
vim.opt.laststatus = 2
vim.opt.wildmenu = true
vim.opt.ruler = true
vim.opt.history = 2000
vim.opt.showmatch = true

vim.scriptencoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = 'ucs-bom,utf-8,euc-jp,cp932'
vim.opt.fileformats = 'dos,unix,mac'
vim.opt.encoding = "utf-8"
vim.opt.helplang = { 'ja', 'en' }


vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.pumblend = 30


vim.g.airline_powerline_fonts = 1


vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4


vim.opt.clipboard:append('unnamedplus')
if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 or vim.fn.has('win32unix') == 1 then
    vim.g.clipboard = {
        name = "win32yank",
        copy = {
            ["+"] = "win32yank.exe -i --crlf",
            ["*"] = "win32yank.exe -i --crlf",
        },
        paste = {
            ["+"] = "win32yank.exe -o --lf",
            ["*"] = "win32yank.exe -o --lf",
        },
        cache_enabled = 0,
    }
end


vim.opt.winborder = "rounded"
