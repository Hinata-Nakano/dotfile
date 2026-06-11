local M = {}

function M.setup_gitsigns()
  require("gitsigns").setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "-" },
      changedelete = { text = "~" },
      untracked = { text = "?" },
    },
    signs_staged_enable = true,
    current_line_blame = false,
    current_line_blame_opts = {
      delay = 500,
      virt_text_pos = "eol",
    },
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, {
          buffer = bufnr,
          desc = desc,
          silent = true,
        })
      end

      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, "Next Git hunk")

      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, "Previous Git hunk")

      map("n", "<leader>hp", gitsigns.preview_hunk, "Preview Git hunk")
      map("n", "<leader>hs", gitsigns.stage_hunk, "Stage/unstage Git hunk")
      map("n", "<leader>hr", gitsigns.reset_hunk, "Reset Git hunk")
      map("n", "<leader>hS", gitsigns.stage_buffer, "Stage current buffer")
      map("n", "<leader>hu", gitsigns.undo_stage_hunk, "Undo staged Git hunk")
      map("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, "Blame current line")
      map("n", "<leader>hB", gitsigns.toggle_current_line_blame, "Toggle inline Git blame")
      map("n", "<leader>hd", gitsigns.diffthis, "Diff current file")

      map("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage selected Git hunk")
      map("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset selected Git hunk")
      map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select Git hunk")
    end,
  })
end

return M
