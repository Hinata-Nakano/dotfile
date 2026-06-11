require("conform").setup({
  formatters_by_ft = {
    kotlin = { "ktlint" },
    kts = { "ktlint" },
  },
  format_on_save = function(bufnr)
    local filetype = vim.bo[bufnr].filetype
    if filetype == "kotlin" or filetype == "kts" then
      return { timeout_ms = 3000, lsp_fallback = true }
    end
  end,
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { silent = true, desc = "Format buffer" })
