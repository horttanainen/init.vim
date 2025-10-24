local opt = vim.opt
local api = vim.api
local cmd = vim.cmd
local g = vim.g
local env = vim.env
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup
local map = vim.keymap.set
local global_opt = vim.opt_global

-- status -----------------------

opt.statusline = [[%!luaeval('require("status").statusline()')]]

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

autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            api.nvim_exec("normal! g'\"",false)
        end
    end
})

-- Indentation and tabs --------------------------------------------------------

opt.smartindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

opt.shiftround = true

vim.opt.formatoptions:remove({ 'r', 'o' })

-- Syntax, color, and hightlighting --------------------------------------------

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

-- lsp -
map("n", "<leader>cd", vim.lsp.buf.definition)
map("n", "<leader>ct", vim.lsp.buf.type_definition)
map("n", "<leader>cr", vim.lsp.buf.references)
map("n", "<leader>ci", vim.lsp.buf.implementation)
map("n", "<leader>ch", vim.lsp.buf.hover)

map("n", "<leader>cf", function()
      vim.lsp.buf.format({ async = true })
end)

map("n", "<leader>cn", function()
  vim.diagnostic.goto_next()
end)

map("n", "<leader>cp", function()
  vim.diagnostic.goto_prev()
end)

map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>ca", vim.lsp.buf.code_action)
map("n", "<leader>cl", vim.lsp.codelens.run)
map("n", "<leader>sh", vim.lsp.buf.signature_help)

map("n", "<leader>e", function()
  vim.diagnostic.open_float(0, {scope="line"})
end)

-- LSP -------------------------------------------------------------------------

vim.lsp.enable('ts_ls')
vim.lsp.enable('zls')
vim.lsp.enable('bashls')

map({'n', 'v'}, '<leader>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true, silent = true})

-- plugins -------------------------------------------------------------------------

require("config.lazy")
