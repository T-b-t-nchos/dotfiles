-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Save&Quit
vim.keymap.set("n", "<leader>wqa", function()
    vim.cmd("wa")
    vim.cmd("qa")
end, { desc = "Save All & Quit All", silent = true })


-- Style
vim.keymap.set("n", "<leader>=", function()
    local view = vim.fn.winsaveview()
    vim.cmd("normal! gg=G")
    vim.fn.winrestview(view)
end, { desc = "Reindent buffer (keep cursor)" })


-- Move cursor
vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)', {})
vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)', {})

-- Indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")


-- move buffers
vim.keymap.set("n", "<leader>bj", "<cmd>bnext<CR>", { silent = true, desc = "Move Buffer Next(→)"})
vim.keymap.set("n", "<leader>bk", "<cmd>bprev<CR>", { silent = true, desc = "Move Buffer Prev(←)"})
vim.keymap.set("n", "<leader>b<Left>", "<cmd>bprev<CR>", { silent = true, desc = "Move Buffer Prev(←)"})
vim.keymap.set("n", "<leader>b<Right>", "<cmd>bnext<CR>", { silent = true, desc = "Move Buffer Next(→)"})
vim.keymap.set("n", "<leader>bh", "<cmd>bprev<CR>", { silent = true, desc = "Move Buffer Prev(←)"})
vim.keymap.set("n", "<leader>bl", "<cmd>bnext<CR>", { silent = true, desc = "Move Buffer Next(→)"})


-- neotree
vim.keymap.set("n", "<leader>nf", "<cmd>Neotree toggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>ne", "<cmd>Neotree filesystem toggle<CR>")
vim.keymap.set("n", "<leader>nb", "<cmd>Neotree buffers toggle<CR>")
vim.keymap.set("n", "<leader>ng", "<cmd>Neotree git_status toggle<CR>")
vim.keymap.set("n", "<leader>f", function()
    vim.cmd("cd %:p:h")
    vim.cmd("Neotree filesystem reveal toggle left")
    --vim.cmd("wincmd l")
end, { desc = "Neo-tree toggle & reveal current file" })


-- Outline (aerial.nvim)
vim.keymap.set("n", "<leader>l", "<cmd>AerialToggle<CR>", { desc = "Outline Window" })
vim.keymap.set("n", "<C-{>", "<cmd>AerialPrev<CR>")
vim.keymap.set("n", "<C-}>", "<cmd>AerialNext<CR>")


-- sprit
vim.keymap.set("n", "<leader>|", "<cmd>vsplit<cr>", { silent = true, desc = "vsprit" })
vim.keymap.set("n", "<leader>-", "<cmd>split<cr>", { silent = true, desc = "hsprit" })


-- pane move prefix: <leader>w + arrow
vim.keymap.set("n", "<leader>w<Left>", "<C-w>h", { desc = "Pane left" })
vim.keymap.set("n", "<leader>w<Right>", "<C-w>l", { desc = "Pane right" })
vim.keymap.set("n", "<leader>w<Up>", "<C-w>k", { desc = "Pane up" })
vim.keymap.set("n", "<leader>w<Down>", "<C-w>j", { desc = "Pane down" })
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Pane left" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Pane right" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Pane up" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Pane down" })
vim.keymap.set("n", "<leader>wH", "<C-w>H", { desc = "Pane move left" })
vim.keymap.set("n", "<leader>wL", "<C-w>L", { desc = "Pane move right" })
vim.keymap.set("n", "<leader>wK", "<C-w>K", { desc = "Pane move up" })
vim.keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "Pane move down" })

-- vim.keymap.set("n", "<leader>wa",  "<C-w>h", { desc = "Window left" })
-- vim.keymap.set("n", "<leader>wd", "<C-w>l", { desc = "Window right" })
-- vim.keymap.set("n", "<leader>ww",    "<C-w>k", { desc = "Window up" })
-- vim.keymap.set("n", "<leader>ws",  "<C-w>j", { desc = "Window down" })

-- terminal(old)
--vim.keymap.set("n", "<leader>tc", "<cmd>belowright split | resize 10 | terminal cmd<cr>", { silent = true, desc = "Cmd" })
--vim.keymap.set("n", "<leader>tp", "<cmd>belowright split | resize 10 | terminal pwsh<cr>", { silent = true, desc = "Pwsh" })
--vim.keymap.set("n", "<leader>tb", "<cmd>belowright split | resize 10 | terminal bash<cr>", { silent = true, desc = "Git Bash" })
--vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])


-- toggleterm
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", { silent = true, desc = "Toggle Terminal" })
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
vim.keymap.set("n", "<leader>xx", "<cmd>diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xs", "<cmd>symbols toggle focus=false<CR>", { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>xl", "<cmd>lsp toggle focus=false win.position=right<CR>", { desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set("n", "<leader>xL", "<cmd>loclist toggle<CR>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })


-- Oil
vim.keymap.set("n", "<leader>.", "<cmd>Oil<cr>", { silent = true, desc = "Open Oil"})


-- neogen
vim.keymap.set("n", "<leader>d", function()
    require("neogen").generate()
end, { desc = "Generate doc comment (neogen)" })


-- Comment 
-- vim.keymap.set("n", "<leader>cc", function() require('Comment.api').toggle.linewise.current() end, { noremap = true, silent = true, desc = "Toggle Comment (linewise)" })
-- vim.keymap.set("n", "<leader>cb", function() require('Comment.api').toggle.blockwise.current() end, { noremap = true, silent = true, desc = "Toggle Comment (blockwise)" })


-- lazygit
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { silent = true, desc = "Open Lazygit"})


-- gitgraph
vim.keymap.set("n", "<leader>gl", function() require("gitgraph").draw({}, { all = true, max_count = 5000 }) end, { silent = true, desc = "Open GitGraph" })


-- diffview
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { silent = true, desc = "Open Diffview" })


-- markdown preview
vim.keymap.set("n", "<leader>mp", "<cmd>terminal mdpv %:p<cr>", { silent = true, desc = "Start Markdown preview" })


-- Octo
vim.keymap.set("n", "<leader>oo", "<cmd>Octo<cr>", { silent = true, desc = "Octo list" })

vim.keymap.set("n", "<leader>oil", "<cmd>Octo issue list<cr>", { silent = true, desc = "gh Issue list" })
vim.keymap.set("n", "<leader>oie", "<cmd>Octo issue edit<cr>", { silent = true, desc = "gh Issue edit" })
vim.keymap.set("n", "<leader>oic", "<cmd>Octo issue close<cr>", { silent = true, desc = "gh Issue close" })
vim.keymap.set("n", "<leader>oib", "<cmd>Octo issue browser<cr>", { silent = true, desc = "gh Issue browser" })
vim.keymap.set("n", "<leader>oin", "<cmd>Octo issue create<cr>", { silent = true, desc = "gh Issue create" })

vim.keymap.set("n", "<leader>opl", "<cmd>Octo pr list<cr>", { silent = true, desc = "gh PR list" })
vim.keymap.set("n", "<leader>ope", "<cmd>Octo pr edit<cr>", { silent = true, desc = "gh PR edit" })
vim.keymap.set("n", "<leader>opc", "<cmd>Octo pr close<cr>", { silent = true, desc = "gh PR close" })
vim.keymap.set("n", "<leader>opb", "<cmd>Octo pr browser<cr>", { silent = true, desc = "gh PR browser" })
vim.keymap.set("n", "<leader>opc", "<cmd>Octo pr create<cr>", { silent = true, desc = "gh PR create" })
vim.keymap.set("n", "<leader>opn", "<cmd>Octo pr create<cr> <BAR>:Octo pr draft<cr>", { silent = true, desc = "gh PR new draft" })


-- ccc
vim.keymap.set("n", "<leader>cp", "<cmd>CccPick<cr>", { silent = true, desc = "Color CccPick"})


-- minty
vim.keymap.set("n", "<leader>cm", "<cmd>Huefy<cr>", { silent = true, desc = "Minty/Huefy" })
vim.keymap.set("n", "<leader>cM", "<cmd>Shades<cr>", { silent = true, desc = "Minty/Shades" })


-- Neo-Img
vim.keymap.set("n", "<leader>ip", "<cmd>NeoImg DisplayImage<cr>", { silent = true, desc = "Preview Image" })


-- Ddx.vim
vim.keymap.set("n", "<leader>h", function()
    vim.fn["ddx#start"]({
        name = "default",
        path = vim.fn.expand("%:p"),
        ui = "hex",
    })
end, {
noremap = true,
silent = true,
desc = "Open file in ddx hex editor"
})


-- comfortable motion
vim.keymap.set("n", "<C-d>", "<cmd>call comfortable_motion#flick(100)<cr>", { silent = true })
vim.keymap.set("n", "<C-u>", "<cmd>call comfortable_motion#flick(-100)<cr>", { silent = true })
vim.keymap.set("n", "<C-f>", "<cmd>call comfortable_motion#flick(200)<cr>", { silent = true })
vim.keymap.set("n", "<C-b>", "<cmd>call comfortable_motion#flick(-200)<cr>", { silent = true })


-- Dial.nvim
vim.keymap.set("n", "<C-a>", function()
    require("dial.map").manipulate("increment", "normal")
end)
vim.keymap.set("n", "<C-x>", function()
    require("dial.map").manipulate("decrement", "normal")
end)
vim.keymap.set("n", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gnormal")
end)
vim.keymap.set("n", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gnormal")
end)
vim.keymap.set("x", "<C-a>", function()
    require("dial.map").manipulate("increment", "visual")
end)
vim.keymap.set("x", "<C-x>", function()
    require("dial.map").manipulate("decrement", "visual")
end)
vim.keymap.set("x", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gvisual")
end)
vim.keymap.set("x", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gvisual")
end)

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
            h = "Move Left",
            l = "Move Right",
            k = "Move Up",
            j = "Move Down",
        },
        ["<leader>wq"] = {
            name = "Quit/Save",
            a = "Save All & Quit All",
        },
    })
end
