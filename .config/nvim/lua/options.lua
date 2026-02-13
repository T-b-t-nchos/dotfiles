vim.fn.stdpath("config")
vim.fn.stdpath("data")
vim.fn.stdpath("cache")


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


vim.opt.guifont = "Moralerspace Neon:h11"
vim.opt.guifontwide = "Moralerspace Neon:h11"


vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.pumblend = 20


vim.g.airline_powerline_fonts = 1


vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4


vim.opt.clipboard:append('unnamedplus')


