vim.loader.enable()

require("options")
require("keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "colors.Aquavium.init" },
        { import = "colors" },
        { import = "plugins.funny" },
        { import = "plugins.lsp" },
        { import = "plugins.git" },
        { import = "plugins" },
    },
    defaults = {
        lazy = true,
        version = false,
    },
    checker = { enabled = true },
})


if vim.fn.executable("zenhan") == 1 then
    for _, event in ipairs({ "InsertLeave", "CmdlineLeave" }) do
    vim.api.nvim_create_autocmd(event, {
        pattern = "*",
        callback = function(_)
            vim.fn.system("zenhan 0")
        end,
    })
    end
end


vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local bufnr = args.buf

        local ft = vim.bo[bufnr].filetype
        if not ft or ft == "" then
            return
        end

        local ok = pcall(vim.treesitter.start, bufnr, ft)
        if not ok then
            return
        end
    end,
})
