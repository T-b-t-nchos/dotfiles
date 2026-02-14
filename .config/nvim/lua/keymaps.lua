-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Save&Quit
vim.keymap.set("n", "<leader>wqa", function()
    vim.cmd("wa")
    vim.cmd("qa")
end, { desc = "Save All & Quit All", silent = true })


-- move buffers
vim.keymap.set("n", "<leader>bj", ":bprev<CR>", { silent = true, desc = "Move Buffer Prev(←)"})
vim.keymap.set("n", "<leader>bk", ":bnext<CR>", { silent = true, desc = "Move Buffer Next(→)"})
vim.keymap.set("n", "<leader>b<Left>", ":bprev<CR>", { silent = true, desc = "Move Buffer Prev(←)"})
vim.keymap.set("n", "<leader>b<Right>", ":bnext<CR>", { silent = true, desc = "Move Buffer Next(→)"})


-- neotree
vim.keymap.set("n", "<leader>nf", ":Neotree toggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>ne", ":Neotree filesystem toggle<CR>")
vim.keymap.set("n", "<leader>nb", ":Neotree buffers toggle<CR>")
vim.keymap.set("n", "<leader>ng", ":Neotree git_status toggle<CR>")
vim.keymap.set("n", "<leader>f", function()
    vim.cmd("cd %:p:h")
    vim.cmd("Neotree filesystem reveal toggle left")
    --vim.cmd("wincmd l")
end, { desc = "Neo-tree toggle & reveal current file" })


-- catppuccin toggle transparent
vim.keymap.set("n", "<C-p>", function()
    local cat = require("catppuccin")
    cat.options.transparent_background = not cat.options.transparent_background
    cat.compile()
    vim.cmd.colorscheme("catppuccin-mocha")
end)
vim.keymap.set("n", "<leader>t", ":terminal<cr>", { silent = true, desc = "terminal" })


-- Outline (aerial.nvim)
vim.keymap.set("n", "<leader>l", "<cmd>AerialToggle<CR>", { desc = "Outline Window" })
vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>")
vim.keymap.set("n", "}", "<cmd>AerialNext<CR>")


-- sprit
vim.keymap.set("n", "<leader>|", ":vsplit<cr>", { silent = true, desc = "vsprit" })
vim.keymap.set("n", "<leader>-", ":split<cr>", { silent = true, desc = "hsprit" })


-- window move prefix: <leader>w + arrow
vim.keymap.set("n", "<leader>w<Left>",  "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<leader>w<Right>", "<C-w>l", { desc = "Window right" })
vim.keymap.set("n", "<leader>w<Up>",    "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<leader>w<Down>",  "<C-w>j", { desc = "Window down" })

-- vim.keymap.set("n", "<leader>wa",  "<C-w>h", { desc = "Window left" })
-- vim.keymap.set("n", "<leader>wd", "<C-w>l", { desc = "Window right" })
-- vim.keymap.set("n", "<leader>ww",    "<C-w>k", { desc = "Window up" })
-- vim.keymap.set("n", "<leader>ws",  "<C-w>j", { desc = "Window down" })

-- terminal(old)
--vim.keymap.set("n", "<leader>tc", ":belowright split | resize 10 | terminal cmd<cr>", { silent = true, desc = "Cmd" })
--vim.keymap.set("n", "<leader>tp", ":belowright split | resize 10 | terminal pwsh<cr>", { silent = true, desc = "Pwsh" })
--vim.keymap.set("n", "<leader>tb", ":belowright split | resize 10 | terminal bash<cr>", { silent = true, desc = "Git Bash" })
--vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])


-- toggleterm
vim.keymap.set("n", "<leader>t", ":ToggleTerm<cr>", { silent = true, desc = "Toggle Terminal" })
--vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-n>", [[<C-\><C-n>]])


-- setup usual environment
vim.keymap.set("n", "<leader>s", function()
  vim.cmd("ToggleTerm direction=horizontal focus=false")
  vim.cmd("normal! L")
  vim.cmd("wincmd k")
  vim.cmd("cd %:p:h")
  vim.cmd("Neotree filesystem reveal toggle left")
  vim.cmd("wincmd l")
  vim.cmd("AerialToggle")
  vim.cmd("wincmd h")
  vim.cmd("wincmd k")
end, { desc = "Setup usual environment" })


-- Trouble keymaps
vim.keymap.set("n", "<leader>xx", function()
  vim.cmd("Trouble diagnostics toggle")
end, { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", function()
  vim.cmd("Trouble diagnostics toggle filter.buf=0")
end, { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xs", function()
  vim.cmd("Trouble symbols toggle focus=false")
end, { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>xl", function()
  vim.cmd("Trouble lsp toggle focus=false win.position=right")
end, { desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set("n", "<leader>xL", function()
  vim.cmd("Trouble loclist toggle")
end, { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", function()
  vim.cmd("Trouble qflist toggle")
end, { desc = "Quickfix List (Trouble)" })


-- Oil
vim.keymap.set("n", "<leader>.", ":Oil<cr>", { silent = true, desc = "Open Oil"})


-- neogen
vim.keymap.set("n", "<leader>d", function()
    require("neogen").generate()
end, { desc = "Generate doc comment (neogen)" })


-- Comment 
-- vim.keymap.set("n", "<leader>cc", function() require('Comment.api').toggle.linewise.current() end, { noremap = true, silent = true, desc = "Toggle Comment (linewise)" })
-- vim.keymap.set("n", "<leader>cb", function() require('Comment.api').toggle.blockwise.current() end, { noremap = true, silent = true, desc = "Toggle Comment (blockwise)" })


-- lazygit
vim.keymap.set("n", "<leader>gg", ":LazyGit<cr>", { silent = true, desc = "Open Lazygit"})


-- gitgraph
vim.keymap.set("n", "<leader>gl", function() require("gitgraph").draw({}, { all = true, max_count = 5000 }) end, { silent = true, desc = "Open GitGraph" })


-- markdown preview
vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<cr>", { silent = true, desc = "Start Markdown preview" })


-- Octo
vim.keymap.set("n", "<leader>oo", ":Octo<cr>", { silent = true, desc = "Octo list" })

vim.keymap.set("n", "<leader>oil", ":Octo issue list<cr>", { silent = true, desc = "gh Issue list" })
vim.keymap.set("n", "<leader>oie", ":Octo issue edit<cr>", { silent = true, desc = "gh Issue edit" })
vim.keymap.set("n", "<leader>oic", ":Octo issue close<cr>", { silent = true, desc = "gh Issue close" })
vim.keymap.set("n", "<leader>oib", ":Octo issue browser<cr>", { silent = true, desc = "gh Issue browser" })
vim.keymap.set("n", "<leader>oin", ":Octo issue create<cr>", { silent = true, desc = "gh Issue create" })

vim.keymap.set("n", "<leader>opl", ":Octo pr list<cr>", { silent = true, desc = "gh PR list" })
vim.keymap.set("n", "<leader>ope", ":Octo pr edit<cr>", { silent = true, desc = "gh PR edit" })
vim.keymap.set("n", "<leader>opc", ":Octo pr close<cr>", { silent = true, desc = "gh PR close" })
vim.keymap.set("n", "<leader>opb", ":Octo pr browser<cr>", { silent = true, desc = "gh PR browser" })
vim.keymap.set("n", "<leader>opn", ":Octo pr create<cr>", { silent = true, desc = "gh PR create" })


-- ccc
vim.keymap.set("n", "<leader>cp", ":CccPick<cr>", { silent = true, desc = "Color CccPick"})


-- which-key integration 
local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        ["<leader>w"] = {
            name = "Window",   -- グループ名
            ["<Left>"]  = "Move Left",
            ["<Right>"] = "Move Right",
            ["<Up>"]    = "Move Up",
            ["<Down>"]  = "Move Down",
            a = "Move Left",
            d = "Move Right",
            w = "Move Up",
            s = "Move Down",
        },
        ["<leader>wq"] = {
            name = "Quit/Save",
            a = "Save All & Quit All",
        },
    })
end
