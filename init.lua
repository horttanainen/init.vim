local opt = vim.opt
local api = vim.api
local cmd = vim.cmd
local g = vim.g
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup
local map = vim.keymap.set

require('plugins')

-- lines -----------------------------------------------------------------------

opt.colorcolumn = "81"

opt.number = true
opt.rnu = true

opt.linebreak = true

-- automations -----------------------------------------------------------------

local rnu_group = augroup("rnu", { clear = true })
autocmd("InsertEnter", {
  pattern = "*",
  command = "set nornu",
  group = rnu_group
})
autocmd("InsertLeave", {
  pattern = "*",
  command = "set rnu",
  group = rnu_group
})

-- Indentation and tabs --------------------------------------------------------

opt.smartindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

opt.shiftround = true

-- Syntax, color, and hightlighting --------------------------------------------

cmd.colorscheme("solarized8")
opt.background = "light"
g.solarized_use16 = 1

opt.ignorecase = true
opt.smartcase = true

-- Backups (fuckups) -----------------------------------------------------------

opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- mappings --------------------------------------------------------------------

g.mapleader = ","

map("i", "jk", "<esc>")

-- open vimrc for editing
map("n", "<leader>ev", ":vsplit $MYVIMRC<cr>")
map("n", "<leader>sv", ":source $MYVIMRC<cr>")

-- quicksave
map("n", "<leader>w", ":w!<cr>")

map({"n", "v", "o"}, "<C-j>", "<C-W>j")
map({"n", "v", "o"}, "<C-k>", "<C-W>k")
map({"n", "v", "o"}, "<C-h>", "<C-W>h")
map({"n", "v", "o"}, "<C-l>", "<C-W>l")

map({"n", "v", "o"}, "<leader>tn", ":tabnew<cr>")
map({"n", "v", "o"}, "<leader>tc", ":tabclose<cr>")

-- open split
map("n", "vv", "<C-w>v")

-- nerd tree
map({"n", "v", "o"}, "<leader>nn", ":NERDTreeToggle<cr>")
map({"n", "v", "o"}, "<leader>nf", ":NERDTreeFind<cr>")

-- Nerd Tree -------------------------------------------------------------------

g.NERDTreeWinPos = "right"
g.NERDTreeWinSize = 35

-- FZF -------------------------------------------------------------------------

