-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local vks = vim.keymap.set

-- Save&Quit
vks("n", "<leader>wqa", function()
    vim.cmd("wa")
    vim.cmd("qa")
end, { desc = "Save All & Quit All", silent = true })


-- Style
vks("n", "<leader>=", function()
    local view = vim.fn.winsaveview()
    vim.cmd("normal! gg=G")
    vim.fn.winrestview(view)
end, { desc = "Reindent buffer (keep cursor)" })


-- Move cursor
vks('n', 'j', '<Plug>(accelerated_jk_gj)', {})
vks('n', 'k', '<Plug>(accelerated_jk_gk)', {})

-- Indent
vks("v", "<", "<gv")
vks("v", ">", ">gv")

-- Telescope
vks("n", "<leader>Tff", "<cmd>Telescope find_files<cr>", { silent = true, desc = "Find File" })
vks("n", "<leader>Tfb", "<cwd>Telescope file_browser<cr>", { silent = true, desc = "File Browser" })
vks("n", "<leader>Tfd", "<cmd>Telescope find_files cwd_only=true<cr>", { silent = true, desc = "Find File in cwd" })
vks("n", "<leader>Tg", "<cmd>Telescope live_grep<cr>", { silent = true, desc = "Live Grep" })
vks("n", "<leader>Tb", "<cmd>Telescope buffers<cr>", { silent = true, desc = "Buffers" })
vks("n", "<leader>Tn", "<cmd>Telescope nerdy<cr>", { silent = true, desc = "Nerdy" })
vks("n", "<leader>Tc", "<cmd>Telescope colorscheme<cr>", { silent = true, desc = "Colorscheme" })
vks("n", "<leader>Th", "<cmd>Telescope help_tags<cr>", { silent = true, desc = "Help" })
vks("n", "<leader>Tk", "<cmd>Telescope keymaps<cr>", { silent = true, desc = "Keymaps" })
vks("n", "<leader>Tv", "<cmd>Telescope vim_options<cr>", { silent = true, desc = "Vim Options" })
vks("n", "<leader>Tr", "<cmd>Telescope registers<cr>", { silent = true, desc = "Registers" })

-- move buffers
vks("n", "<leader>bj", "<cmd>bnext<CR>", { silent = true, desc = "Move Buffer Next(→)"})
vks("n", "<leader>bk", "<cmd>bprev<CR>", { silent = true, desc = "Move Buffer Prev(←)"})
vks("n", "<leader>b<Left>", "<cmd>bprev<CR>", { silent = true, desc = "Move Buffer Prev(←)"})
vks("n", "<leader>b<Right>", "<cmd>bnext<CR>", { silent = true, desc = "Move Buffer Next(→)"})
vks("n", "<leader>bh", "<cmd>bprev<CR>", { silent = true, desc = "Move Buffer Prev(←)"})
vks("n", "<leader>bl", "<cmd>bnext<CR>", { silent = true, desc = "Move Buffer Next(→)"})
vks("n", "H", "<cmd>bprev<CR>", { silent = true, desc = "Move Buffer Prev(←)"})
vks("n", "L", "<cmd>bnext<CR>", { silent = true, desc = "Move Buffer Next(→)"})


-- neotree
vks("n", "<leader>nf", "<cmd>Neotree toggle<CR>", { silent = true })
vks("n", "<leader>ne", "<cmd>Neotree filesystem toggle<CR>")
vks("n", "<leader>nb", "<cmd>Neotree buffers toggle<CR>")
vks("n", "<leader>ng", "<cmd>Neotree git_status toggle<CR>")
vks("n", "<leader>f", function()
    vim.cmd("cd %:p:h")
    vim.cmd("Neotree filesystem reveal toggle left")
    --vim.cmd("wincmd l")
end, { desc = "Neo-tree toggle & reveal current file" })


-- Outline (aerial.nvim)
vks("n", "<leader>l", "<cmd>AerialToggle<CR>", { desc = "Outline Window" })
vks("n", "<C-{>", "<cmd>AerialPrev<CR>")
vks("n", "<C-}>", "<cmd>AerialNext<CR>")


-- Window
vks("n", "<leader>|", "<cmd>vsplit<cr>", { silent = true, desc = "vsprit" })
vks("n", "<leader>-", "<cmd>split<cr>", { silent = true, desc = "hsprit" })
vks("n", "<leader>wd", "<C-W>c", { silent = true, desc = "close window" })


-- pane move prefix: Ctrl + hjkl
vks("n", "<C-h>", "<C-w>h",  { desc = "Pane left" })
vks("n", "<C-l>", "<C-w>l",  { desc = "Pane right" })
vks("n", "<C-k>", "<C-w>k", { desc = "Pane up" })
vks("n", "<C-j>", "<C-w>j", { desc = "Pane down" })
vks("n", "<C-A-h>", "<C-w>H",  { desc = "Pane left" })
vks("n", "<C-A-l>", "<C-w>L",  { desc = "Pane right" })
vks("n", "<C-A-k>", "<C-w>K", { desc = "Pane up" })
vks("n", "<C-A-j>", "<C-w>J", { desc = "Pane down" })

-- resize pane
vks("n", "<C-Up>", "<cmd>resize +1<CR>", { silent = true })
vks("n", "<C-Down>", "<cmd>resize -1<CR>", { silent = true })
vks("n", "<C-Left>", "<cmd>vertical resize -1<CR>", { silent = true })
vks("n", "<C-Right>", "<cmd>vertical resize +1<CR>", { silent = true })

-- vks("n", "<leader>wa",  "<C-w>h", { desc = "Window left" })
-- vks("n", "<leader>wd", "<C-w>l", { desc = "Window right" })
-- vks("n", "<leader>ww",    "<C-w>k", { desc = "Window up" })
-- vks("n", "<leader>ws",  "<C-w>j", { desc = "Window down" })

-- terminal(old)
--vks("n", "<leader>tc", "<cmd>belowright split | resize 10 | terminal cmd<cr>", { silent = true, desc = "Cmd" })
--vks("n", "<leader>tp", "<cmd>belowright split | resize 10 | terminal pwsh<cr>", { silent = true, desc = "Pwsh" })
--vks("n", "<leader>tb", "<cmd>belowright split | resize 10 | terminal bash<cr>", { silent = true, desc = "Git Bash" })
--vks("t", "<Esc>", [[<C-\><C-n>]])


-- toggleterm
vks("n", "<C-\\>", "<cmd>ToggleTerm<cr>", { silent = true, desc = "toggle terminal" })
vks("i", "<C-\\>", "<cmd>ToggleTerm<cr>", { silent = true, desc = "toggle terminal" })
--vks("t", "<Esc>", [[<C-\><C-n>]])
vks("t", "<C-n>", [[<C-\><C-n>]])


-- setup usual environment
vks("n", "<leader>s", function()
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
vks("n", "<leader>xx", "<cmd>diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
vks("n", "<leader>xX", "<cmd>diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics (Trouble)" })
vks("n", "<leader>xs", "<cmd>symbols toggle focus=false<CR>", { desc = "Symbols (Trouble)" })
vks("n", "<leader>xl", "<cmd>lsp toggle focus=false win.position=right<CR>", { desc = "LSP Definitions / references / ... (Trouble)" })
vks("n", "<leader>xL", "<cmd>loclist toggle<CR>", { desc = "Location List (Trouble)" })
vks("n", "<leader>xQ", "<cmd>qflist toggle<CR>", { desc = "Quickfix List (Trouble)" })


-- Oil
vks("n", "<leader>.", "<cmd>Oil<cr>", { silent = true, desc = "Open Oil"})


-- neogen
vks("n", "<leader>d", function()
    require("neogen").generate()
end, { desc = "Generate doc comment (neogen)" })


-- Comment 
-- vks("n", "<leader>cc", function() require('Comment.api').toggle.linewise.current() end, { noremap = true, silent = true, desc = "Toggle Comment (linewise)" })
-- vks("n", "<leader>cb", function() require('Comment.api').toggle.blockwise.current() end, { noremap = true, silent = true, desc = "Toggle Comment (blockwise)" })


-- lazygit
vks("n", "<leader>gg", "<cmd>LazyGit<cr>", { silent = true, desc = "Open Lazygit"})


-- gitgraph
vks("n", "<leader>gl", function() require("gitgraph").draw({}, { all = true, max_count = 5000 }) end, { silent = true, desc = "Open GitGraph" })


-- diffview
vks("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { silent = true, desc = "Open Diffview" })


-- markdown preview
vks("n", "<leader>pm", "<cmd>terminal mdpv %:p<cr>", { silent = true, desc = "Start Markdown preview" })


-- Octo
vks("n", "<leader>oo", "<cmd>Octo<cr>", { silent = true, desc = "Octo list" })

vks("n", "<leader>oil", "<cmd>Octo issue list<cr>", { silent = true, desc = "gh Issue list" })
vks("n", "<leader>oie", "<cmd>Octo issue edit<cr>", { silent = true, desc = "gh Issue edit" })
vks("n", "<leader>oic", "<cmd>Octo issue close<cr>", { silent = true, desc = "gh Issue close" })
vks("n", "<leader>oib", "<cmd>Octo issue browser<cr>", { silent = true, desc = "gh Issue browser" })
vks("n", "<leader>oin", "<cmd>Octo issue create<cr>", { silent = true, desc = "gh Issue create" })

vks("n", "<leader>opl", "<cmd>Octo pr list<cr>", { silent = true, desc = "gh PR list" })
vks("n", "<leader>ope", "<cmd>Octo pr edit<cr>", { silent = true, desc = "gh PR edit" })
vks("n", "<leader>opc", "<cmd>Octo pr close<cr>", { silent = true, desc = "gh PR close" })
vks("n", "<leader>opb", "<cmd>Octo pr browser<cr>", { silent = true, desc = "gh PR browser" })
vks("n", "<leader>opc", "<cmd>Octo pr create<cr>", { silent = true, desc = "gh PR create" })
vks("n", "<leader>opn", "<cmd>Octo pr create<cr> <BAR>:Octo pr draft<cr>", { silent = true, desc = "gh PR new draft" })


-- ccc
vks("n", "<leader>cp", "<cmd>CccPick<cr>", { silent = true, desc = "Color CccPick"})


-- minty
vks("n", "<leader>cm", "<cmd>Huefy<cr>", { silent = true, desc = "Minty/Huefy" })
vks("n", "<leader>cM", "<cmd>Shades<cr>", { silent = true, desc = "Minty/Shades" })


-- Neo-Img
vks("n", "<leader>ip", "<cmd>NeoImg DisplayImage<cr>", { silent = true, desc = "Preview Image" })


-- Ddx.vim
vks("n", "<leader>h", function()
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
vks("n", "<C-d>", "<cmd>call comfortable_motion#flick(100)<cr>", { silent = true })
vks("n", "<C-u>", "<cmd>call comfortable_motion#flick(-100)<cr>", { silent = true })
vks("n", "<C-f>", "<cmd>call comfortable_motion#flick(200)<cr>", { silent = true })
vks("n", "<C-b>", "<cmd>call comfortable_motion#flick(-200)<cr>", { silent = true })


-- Dial.nvim
vks("n", "<C-a>", function()
    require("dial.map").manipulate("increment", "normal")
end)
vks("n", "<C-x>", function()
    require("dial.map").manipulate("decrement", "normal")
end)
vks("n", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gnormal")
end)
vks("n", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gnormal")
end)
vks("x", "<C-a>", function()
    require("dial.map").manipulate("increment", "visual")
end)
vks("x", "<C-x>", function()
    require("dial.map").manipulate("decrement", "visual")
end)
vks("x", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gvisual")
end)
vks("x", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gvisual")
end)


-- Rayso
vks("v", "<leader>ss", "<cmd>Rayso<cr>", { silent = true, desc = "Export to Rayso" })


-- Neominimap
vks("n", "<leader>nm", "<cmd>Neominimap Toggle<cr>", { silent = true, desc = "Neominimap" })


-- NeoNuGet
vks("n", "<leader>#n", "<cmd>Nuget<cr>", { silent = true, desc = "NeoNuGet" })


-- csharp.nvim
vks("n", "<leader>#d", function () require("csharp").debug_project() end, { silent = true, desc = "Effortless Debugging" })
vks("n", "<leader>#r", function () require("csharp").run_project() end, { silent = true, desc = "Run project" })
vks("n", "<leader>#u", function () require("csharp").fix_usings() end, { silent = true, desc = "Fix usings" })


-- vim-kensaku-search
vks("c", "<cr>", "<Plug>(kensaku-search-replace)<cr>", { silent = true })


-- in-and-out.nvim
vks("i", "<C-CR>", function() require("in-and-out").in_and_out() end, { silent = true, desc = "In and Out" })


-- SS
-- ss-rubi.nvim
vks("n", "<leader>Srr", "<cmd>RubiInsert<cr>", { silent = true, desc = "RubiInsert" })
vks("v", "<leader>Srr", "<cmd>RubiInsert<cr>", { silent = true, desc = "RubiInsert" })
vks("v", "<leader>Sra", "<cmd>RubiInsertAC<cr>", { silent = true, desc = "RubiInsertAC" })


-- live-preview.nvim
vim.keymap.set("n", "<leader>pl", "<cmd>LivePreview start<cr>", { silent = true, desc = "Live Preview" })


-- yazi.nvim
vim.keymap.set("n", "<leader>yz", "<cmd>Yazi<cr>", { silent = true, desc = "Yazi" })
vim.keymap.set("n", "<leader>yZ", "<cmd>Yazi cwd<cr>", { silent = true, desc = "Yazi in nvim's working directory" })


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
