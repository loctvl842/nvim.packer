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

------------------- Navigate buffers -------------------------
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
------------------- Press jk fast to enter --------------------
keymap("i", "jk", "<ESC>", opts)

-- Visual --
------------------- Stay in indent mode -----------------------
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "p", '"_dP', opts)

------------------- Resize windows ----------------------------
keymap("n", "<A-C-j>", ":resize +1<CR>", opts)
keymap("n", "<A-C-k>", ":resize -1<CR>", opts)
keymap("n", "<A-C-h>", ":vertical resize +1<CR>", opts)
keymap("n", "<A-C-l>", ":vertical resize -1<CR>", opts)

------------------- Move text up/ down ------------------------
-- Visual --
keymap("v", "<A-S-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-S-k>", ":m .-2<CR>==", opts)
-- Block --
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-S-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-S-k>", ":move '<-2<CR>gv-gv", opts)
-- Normal --
keymap("n", "<A-S-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-S-k>", ":m .-2<CR>==", opts)
-- Insert --
keymap("i", "<A-S-j>", "<ESC>:m .+1<CR>==gi", opts)
keymap("i", "<A-S-k>", "<ESC>:m .-2<CR>==gi", opts)

------------------- No highlight ------------------------------
keymap("n", ";", ":noh<CR>", opts)

------------------- Formatter ---------------------------------
keymap("n", "<C-f>", ":lua vim.lsp.buf.formatting()<CR>", opts)

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
keymap("n", "<leader>\\", ":vsplit<CR> <ESC>:lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<leader>/", ":split<CR> <ESC>:lua require('telescope.builtin').find_files()<cr>", opts)

------------------- Switch two windows ------------------------
keymap("n", "<A-o>", "<C-w>r", opts)

------------------------- Fold --------------------------------
keymap("v", "ff", "zf", opts) -- create fold
keymap("n", "fd", "zd", opts) -- delete fold
keymap("n", "fo", "zo", opts) -- open fold
keymap("n", "fc", "zc", opts) -- close fold
keymap("n", "fa", "za", opts) -- toggle fold
keymap("n", "fA", "zA", opts) -- toggle all fold under cursor

----------------------- Ranger --------------------------------
keymap("n", "<leader>o", ":RnvimrToggle<CR>", opts)

-- keymap("n", "/", "<Plug>(incsearch-forward)", opts)
-- keymap("i", "<F2>", '<cmd>lua require("renamer").rename()<cr>', opts)
-- keymap("n", "<leader>rn", '<cmd>lua require("renamer").rename()<cr>', opts)
-- keymap("v", "<leader>rn", '<cmd>lua require("renamer").rename()<cr>', opts)
