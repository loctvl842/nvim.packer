local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
------------------- Better window navigation -----------------
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

------------------- Resize with arrows -----------------------
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

------------------- Navigate buffers -------------------------
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
------------------- Press jk fast to enter --------------------
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
------------------- Stay in indent mode -----------------------
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "p", '"_dP', opts)

------------------- Move text up/ down ------------------------
-- Visual --
keymap("v", "<A-J>", ":m .+1<CR>==", opts)
keymap("v", "<A-K>", ":m .-2<CR>==", opts)
-- Block --
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-J>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-K>", ":move '<-2<CR>gv-gv", opts)
-- Normal --
keymap("n", "<A-J>", ":m .+1<CR>==", opts)
keymap("n", "<A-K>", ":m .-2<CR>==", opts)
-- Insert --
keymap("i", "<A-J> <ESC>", ":m .+1<CR>==gi", opts)
keymap("i", "<A-K> <ESC>", ":m .-2<CR>==gi", opts)

------------------- No highlight ------------------------------
keymap("n", ";", ":noh<CR>", opts)

------------------- Formatter ---------------------------------
keymap("n", "<C-f>", ":lua vim.lsp.buf.formatting()<CR>", opts)

------------------- Close buffer quickly ----------------------
keymap("n", "bd", ":Bdelete<CR>", opts)

------------------- Go to buffer quickly ----------------------
keymap("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)

------------------- split window ------------------------------
keymap("n", "<leader>\\", ":vsplit<CR>", opts)
keymap("n", "<leader>/", ":split<CR>", opts)

------------------- Resize windows ----------------------------
keymap("n", "<A-j>", ":resize -1<CR>", opts)
keymap("n", "<A-k>", ":resize +1<CR>", opts)
keymap("n", "<A-h>", ":vertical resize -1<CR>", opts)
keymap("n", "<A-l>", ":vertical resize +1<CR>", opts)

------------------- Switch two windows ------------------------
keymap("n", "<A-o>", "<C-w>r", opts)
