vim.loader.enable()

require("options")
require("keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "colorscheme" }, -- priority=1000 前提
    { import = "plugins.lsp" }, -- LSPは遅延されやすい
    { import = "plugins.git" },
    { import = "plugins" },
})




