local opt = vim.opt
local api = vim.api
local cmd = vim.cmd
local g = vim.g
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup
local map = vim.keymap.set
local global_opt = vim.opt_global

require("plugins")

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

-- Indentation and tabs --------------------------------------------------------

opt.smartindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

opt.shiftround = true

vim.opt_local.formatoptions:remove({ 'r', 'o' })

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

-- completion ------------------------------------------------------------------

-- global_opt.completeopt = { "menu", "menuone", "preview", "noinsert", "noselect" }

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

-- CMD -------------------------------------------------------------------------

local cmp = require("cmp")

cmp.setup({
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--   capabilities = capabilities
-- }

-- metals ----------------------------------------------------------------------

local metals_config = require("metals").bare_config()

metals_config.init_options.statusBarProvider = "on"

metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

-- Dap -------------------------------------------------------------------------

local dap = require("dap")

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "Run or test with input",
    metals = {
      runType = "runOrTestFile",
      args = function()
        local args_string = vim.fn.input("Arguments: ")
        return vim.split(args_string, " +")
      end,
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Run or Test",
    metals = {
      runType = "runOrTestFile",
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
end

