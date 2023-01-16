-- Shorten function name
local keymap = vim.keymap.set

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Standed operations
keymap("n", "<leader>w", "<cmd>w<cr>", { desc = "Write" })
keymap("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
keymap("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "No highlight" })
keymap("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force write" })
keymap("n", "<C-q>", "<cmd>q!<cr>", { desc = "Force quit" })

keymap("n", "<leader>ph", "<cmd>Lazy<cr>", { desc = "Lazy home" })
keymap("n", "<leader>pp", "<cmd>Lazy profile<cr>", { desc = "Lazy profile" })
keymap("n", "<leader>ps", "<cmd>Lazy sync<cr>", { desc = "Lazy sync" })
keymap("n", "<leader>pl", "<cmd>Lazy log<cr>", { desc = "Lazy log" })
keymap("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Lazy update" })

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<esc>", { desc = "Exit insert mode" })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", { desc = "unindent line" })
keymap("v", ">", ">gv", { desc = "indent line" })

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<cr>==", { desc = "Move text down" })
keymap("v", "<A-k>", ":m .-2<cr>==", { desc = "Move text up" })

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<cr>gv-gv", { desc = "Move text down" })
keymap("x", "K", ":move '<-2<cr>gv-gv", { desc = "Move text up" })
keymap("x", "<A-k>", ":move '<-2<cr>gv-gv", { desc = "Move text up" })
keymap("x", "<A-j>", ":move '>+1<cr>gv-gv", { desc = "Move text down" })

-- Terminal --
-- Better terminal navigation
keymap("t", "<esc>", "<C-\\><C-n>", { desc = "Terminal normal mode" })
keymap("t", "jk", "<C-\\><C-n>", { desc = "Terminal normal mode" })
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", { desc = "Terminal left window navigation" })
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", { desc = "Terminal down window navigation" })
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", { desc = "Terminal up window navigation" })
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", { desc = "Terminal right window naviation" })
