-- clipboadにコピペする。yyでOSにコピーしてpでペースト
vim.opt.clipboard = "unnamedplus"

-- 行末の一文字先にもカーソルを置けるようにする
vim.opt.virtualedit = "onemore"

-- nvim 外で変更されたファイルを自動で読み直す
vim.opt.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  command = "checktime",
})
