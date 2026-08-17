-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local vks = vim.keymap.set

-- Save&Quit
vks("n", "<leader>wqa", function()
    vim.cmd("wa")
    vim.cmd("qa")
end, { desc = "Save All & Quit All", silent = true })
vks("n", "<leader>qq", function()
    vim.cmd("qa")
end, { desc = "Quit", silent = true })


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

-- buffers
vks("n", "H", "<cmd>bprev<CR>", { silent = true, desc = "Move Buffer Prev(←)"})
vks("n", "L", "<cmd>bnext<CR>", { silent = true, desc = "Move Buffer Next(→)"})
vks("n", "<leader>bb", "<cmd>e #<cr>", { silent = true, desc = "Switch to other buffer" })
vks("n", "<leader>`", "<cmd>e #<cr>", { silent = true, desc = "Switch to other buffer" })
vks("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Tab
vks("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vks("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
vks("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vks("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vks("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vks("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vks("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Prev Tab" })

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

-- Escape and Clear hlsearch
vks({ "i", "n", "s" }, "<esc>", function()
    if vim.fn.executable("zenhan") == 1 then
        vim.system({ "zenhan", "0" }, { detach = true })
    end
    vim.cmd("noh")
    return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- Swich to normal mode in terminal
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

-- markdown preview
vks("n", "<leader>pm", "<cmd>terminal mdpv %:p<cr>", { silent = true, desc = "Start Markdown preview" })
