-- Silent keymap option
local opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Normal --
-- Better window movement
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<leader>bn", ":bnext<CR>", opts)
keymap("n", "<leader>bp", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>H", ":nohlsearch<CR>", opts)

-- Remove macro
keymap("n", "q", "<nop>", opts)

-- Move through wrapped lines
keymap('n', 'j', function() return vim.v.count > 0 and 'j' or 'gj' end, { expr = true, silent = true })
keymap('n', 'k', function() return vim.v.count > 0 and 'k' or 'gk' end, { expr = true, silent = true })

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Delete word with ctrl+backspace
keymap("i", "<C-BS>", "<C-w>", opts)

-- Delete word with ctrl+delete
keymap("i", "<C-Del>", "<C-o>dw", opts)

-- Visual --
-- Delete current selection and paste while keeping original text
keymap("v", "p", "P", opts)
