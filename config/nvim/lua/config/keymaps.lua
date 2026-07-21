local map = vim.keymap.set

local function close_diffview()
  local ok, lib = pcall(require, "diffview.lib")
  if ok and lib.get_current_view() then
    vim.cmd("DiffviewClose")
  end
end

local function close_neotree()
  if vim.fn.exists(":Neotree") == 2 then
    vim.cmd("Neotree close")
  end
end

local function is_diffview_open()
  local ok, lib = pcall(require, "diffview.lib")
  return ok and lib.get_current_view() ~= nil
end

map("n", "<C-n>", function()
  close_diffview()
  vim.cmd("Neotree toggle")
end, { desc = "Toggle file tree" })
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

-- Git views
map("n", "<leader>gg", function()
  close_neotree()
  if is_diffview_open() then
    vim.cmd("DiffviewClose")
  else
    vim.cmd("DiffviewOpen")
  end
end, { desc = "Toggle Git source control" })
map("n", "<leader>gf", "<cmd>LazyGitCurrentFile<CR>", { desc = "Git UI for current file" })
map("n", "<leader>gF", "<cmd>LazyGitFilterCurrentFile<CR>", { desc = "Current file commits (LazyGit)" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Git diff view" })
map("n", "<leader>gD", "<cmd>DiffviewClose<CR>", { desc = "Close Git diff view" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Current file history" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", { desc = "Repository history" })
map("n", "<leader>gl", function()
  require("gitgraph").draw({}, { all = false, max_count = 5000 })
end, { desc = "Git log graph" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })
vim.keymap.set("i", "jj", "<Esc>", { silent = true, desc = "Exit insert mode" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true, desc = "Exit terminal mode" })

-- Ctrl-z を一般的なエディタの undo として使う
vim.keymap.set("n", "<C-z>", "u", { silent = true })
vim.keymap.set("i", "<C-z>", "<C-o>u", { silent = true })
vim.keymap.set("v", "<C-z>", "<Esc>u", { silent = true })
