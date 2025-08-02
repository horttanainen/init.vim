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


-- CMP -------------------------------------------------------------------------

local cmp = require("cmp")

cmp.setup({
  snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
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

-- LSP -------------------------------------------------------------------------

vim.lsp.enable('ts_ls')
vim.lsp.enable('zls')
vim.lsp.enable('bashls')

vim.lsp.enable('lsp_ai')

local lsp_ai_init_options_json = [[
{
  "memory": {
    "file_store": {}
  },
  "models": {
    "model1": {
        "type": "open_ai",
        "chat_endpoint": "https://api.openai.com/v1/chat/completions",
        "completions_endpoint": "https://api.openai.com/v1/completions",
        "model": "gpt-4o",
        "auth_token_env_var_name": "OPENAI_API_KEY"
    }
  },
  "chat": [
    {
      "trigger": "!C",
      "action_display_name": "Chat",
      "model": "model1",
      "parameters": {
        "max_context": 4096,
        "max_tokens": 1024,
        "messages": [
          {
            "role": "system",
            "content": "You are a code assistant chatbot. The user will ask you for assistance coding and you will do you best to answer succinctly and accurately"
          }
        ]
      }
    }
  ],
  "actions": [
    {
      "action_display_name": "Refactor",
      "model": "model1",
      "parameters": {
        "max_context": 4096,
        "max_tokens": 4096,
        "messages": [
          {
            "role": "system",
            "content": "You are an AI coding assistant specializing in code refactoring. Your task is to analyze the given code snippet and provide a refactored version. Follow these steps:\n\n1. Analyze the code context and structure.\n2. Identify areas for improvement, such as code efficiency, readability, or adherence to best practices.\n3. Provide your chain of thought reasoning as comments in the code. Include your analysis of the current code and explain your refactoring decisions.\n4. Rewrite the entire code snippet with your refactoring applied.\n5. Wrap your refactored code solution in <answer> tags.\n6. it is really important that you wrap your refactored code solution in opening <answer> and closing </answer> tags.\n7. Do not wrap code in anything else than the <answer> tags. \n\nYour response should always include both the reasoning and the refactored code.\n8. Everything inside <answer> tags should be real working code and not markdow.\n9. Use await to execute queries in place instead of trying to run queries in a batch.\n10. Inline sql queries instead of reusing the query variable.\n11. Avoid using t.batch pattern that might have been used in the code.\n\n"
          },
          {
            "role": "user",
            "content": "{SELECTED_TEXT}"
          }
        ]
      }, 
      "post_process": {
        "extractor": "(?s)<answer>(.*?)</answer>"
      }
    }
  ]
}
]]

local lsp_ai_config = {
  cmd = { 'lsp-ai' },
  root_dir = vim.loop.cwd(),
  init_options = vim.fn.json_decode(lsp_ai_init_options_json),
}

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_clients({bufnr = bufnr, name = "lsp-ai"})
    if #client == 0 then
      vim.lsp.start(lsp_ai_config, {bufnr = bufnr})
    end
  end,
})

map({'n', 'v'}, '<leader>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true, silent = true})

-- Dap -------------------------------------------------------------------------

local dap = require("dap")

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/local/opt/llvm/bin/lldb-dap',
  name = 'lldb'
}

dap.configurations.zig = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = '${workspaceFolder}/zig-out/bin/multi',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}
