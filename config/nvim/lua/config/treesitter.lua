require("nvim-treesitter.configs").setup({
  ensure_installed = { "go", "gomod", "gosum", "gowork", "kotlin", "lua", "yaml" },
  highlight = {
    enable = true,
  },
})
