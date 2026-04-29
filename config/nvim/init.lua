-- lazy.nvim のパスを追加
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

-- プラグイン設定
require("lazy").setup({
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
}

  
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
