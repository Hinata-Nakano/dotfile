local map = vim.keymap.set

map("n", "<C-n>", "<cmd>Neotree toggle<CR>", { desc = "Toggle file tree" })
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

-- Git views
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Git UI (LazyGit)" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Git diff view" })
map("n", "<leader>gD", "<cmd>DiffviewClose<CR>", { desc = "Close Git diff view" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Current file history" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", { desc = "Repository history" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })
vim.keymap.set("i", "jj", "<Esc>", { silent = true, desc = "Exit insert mode" })

-- Ctrl-z を一般的なエディタの undo として使う
vim.keymap.set("n", "<C-z>", "u", { silent = true })
vim.keymap.set("i", "<C-z>", "<C-o>u", { silent = true })
vim.keymap.set("v", "<C-z>", "<Esc>u", { silent = true })
