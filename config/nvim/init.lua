-- lazy.nvim のパスを追加
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("config.plugins")
require("config.cmp")
require("config.lsp")
require("config.treesitter")
require("config.neo-tree")
require("config.keymaps")
require("config.options")
