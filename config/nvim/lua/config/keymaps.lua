vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>")
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>g", ":LazyGit<CR>")
vim.keymap.set("i", "jj", "<Esc>", { silent = true, desc = "Exit insert mode" })

-- Ctrl-z を一般的なエディタの undo として使う
vim.keymap.set("n", "<C-z>", "u", { silent = true })
vim.keymap.set("i", "<C-z>", "<C-o>u", { silent = true })
vim.keymap.set("v", "<C-z>", "<Esc>u", { silent = true })
