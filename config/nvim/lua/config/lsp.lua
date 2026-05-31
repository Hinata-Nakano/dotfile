require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "gopls", "kotlin_language_server" },
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

vim.lsp.config("kotlin_language_server", {
  capabilities = capabilities,
})
vim.lsp.enable("kotlin_language_server")

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

local semantic_highlights = {
  variable = { fg = "#dcd7ba" },
  parameter = { fg = "#957fb8", italic = true },
  property = { fg = "#7e9cd8" },
  ["function"] = { fg = "#e6c384" },
  method = { fg = "#e6c384" },
  type = { fg = "#7aa89f", bold = true },
}

for _, language in ipairs({ "go", "kotlin" }) do
  for token_type, highlight in pairs(semantic_highlights) do
    vim.api.nvim_set_hl(0, "@lsp.type." .. token_type .. "." .. language, highlight)
  end
end

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = {
    current_line = true,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
