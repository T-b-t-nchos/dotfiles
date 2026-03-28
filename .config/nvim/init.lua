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
        { import = "colors" },
        { import = "plugins.funny" },
        { import = "plugins.treesitter" },
        { import = "plugins.telescope" },
        { import = "plugins.lsp" },
        { import = "plugins.git" },
        { import = "plugins.test" },
        { import = "plugins" },
    },
    defaults = {
        lazy = true,
        version = false,
    },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "man",
                "matchit",
                "matchparen",
                "netrw",
                "netrwPlugin",
                "tar",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zip",
                "zipPlugin",
            },
        },
    },
    dev = {
        path = "~/source/repos/",
    },
})



-- :Man ----------------------------------------------------
vim.api.nvim_create_user_command("Man", function(opts)
    vim.cmd.runtime("plugin/man.lua")
    vim.cmd("Man " .. (opts.args or ""))
end, {
    nargs = "*",
    complete = "shellcmd",
})
-- netrw (:Explore, :Ex, :Lexplore) ------------------------
local function run_netrw(cmd, args)
    vim.cmd.runtime("plugin/netrwPlugin.vim")
    vim.cmd(cmd .. " " .. (args or ""))
end
vim.api.nvim_create_user_command("Explore", function(opts)
    run_netrw("Explore", opts.args)
end, { nargs = "?" })
vim.api.nvim_create_user_command("Ex", function(opts)
    run_netrw("Ex", opts.args)
end, { nargs = "?" })
vim.api.nvim_create_user_command("Lexplore", function(opts)
    run_netrw("Lexplore", opts.args)
end, { nargs = "?" })
-- :TOhtml -------------------------------------------------
vim.api.nvim_create_user_command("TOhtml", function()
    vim.cmd.runtime("plugin/tohtml.vim")
    vim.cmd("TOhtml")
end, {})
-- :Tutor --------------------------------------------------
vim.api.nvim_create_user_command("Tutor", function()
    vim.cmd.runtime("plugin/tutor.vim")
    vim.cmd.Tutor()
end, {})
-- :zipPlugin ----------------------------------------------
vim.api.nvim_create_autocmd("BufReadCmd", {
    pattern = "*.zip",
    callback = function()
        vim.cmd.runtime("plugin/zipPlugin.vim")
    end,
})
------------------------------------------------------------


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
