-- lazy.nvim のパスを追加
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

-- プラグイン設定
require("lazy").setup({
  -- カラーテーマ
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        theme = "wave",
      })
      vim.cmd.colorscheme("kanagawa-wave")
    end,
  },

  -- ファイルツリー
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    }
  },

  -- ファイル検索
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

{
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
},

  -- LSP / 補完
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "rafamadriz/friendly-snippets" },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },

  -- 構文ハイライト
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
  },

  
})

-- 補完
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- LSP
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "gopls" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.semanticTokens = {
  dynamicRegistration = false,
  tokenTypes = {
    "namespace",
    "type",
    "class",
    "enum",
    "interface",
    "struct",
    "typeParameter",
    "parameter",
    "variable",
    "property",
    "enumMember",
    "event",
    "function",
    "method",
    "macro",
    "keyword",
    "modifier",
    "comment",
    "string",
    "number",
    "regexp",
    "operator",
    "decorator",
  },
  tokenModifiers = {
    "declaration",
    "definition",
    "readonly",
    "static",
    "deprecated",
    "abstract",
    "async",
    "modification",
    "documentation",
    "defaultLibrary",
  },
  formats = { "relative" },
  requests = {
    range = true,
    full = { delta = true },
  },
  multilineTokenSupport = false,
  overlappingTokenSupport = true,
}
vim.lsp.config("gopls", {
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        unusedwrite = true,
      },
      completeUnimported = true,
      staticcheck = true,
      usePlaceholders = true,
    },
  },
})
vim.lsp.enable("gopls")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/documentHighlight") then
      local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = group,
        buffer = args.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = group,
        buffer = args.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

vim.api.nvim_set_hl(0, "@lsp.type.variable.go", { fg = "#dcd7ba" })
vim.api.nvim_set_hl(0, "@lsp.type.parameter.go", { fg = "#957fb8", italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.property.go", { fg = "#7e9cd8" })
vim.api.nvim_set_hl(0, "@lsp.type.function.go", { fg = "#e6c384" })
vim.api.nvim_set_hl(0, "@lsp.type.method.go", { fg = "#e6c384" })
vim.api.nvim_set_hl(0, "@lsp.type.type.go", { fg = "#7aa89f", bold = true })

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- 構文ハイライト
require("nvim-treesitter.configs").setup({
  ensure_installed = { "go", "gomod", "gosum", "gowork", "lua" },
  highlight = {
    enable = true,
  },
})

-- 👇 neo-treeの設定:
require("neo-tree").setup({
  filesystem = {
    cwd_target = {
      sidebar = "cwd",
      current = "cwd",
    },
    follow_current_file = {
      enabled = true,
    },
  },
})

-- キー設定（超重要）
vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>")
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>")
vim.g.mapleader = " "  -- ← これ大事（Spaceをleaderにする）
vim.keymap.set("n", "<leader>g", ":LazyGit<CR>")
--clipboadにコピペする。yyでOSにコピーしてpでペースト
vim.opt.clipboard = "unnamedplus"

-- 行末の一文字先にもカーソルを置けるようにする
vim.opt.virtualedit = "onemore"

-- Ctrl-z を一般的なエディタの undo として使う
vim.keymap.set("n", "<C-z>", "u", { silent = true })
vim.keymap.set("i", "<C-z>", "<C-o>u", { silent = true })
vim.keymap.set("v", "<C-z>", "<Esc>u", { silent = true })
