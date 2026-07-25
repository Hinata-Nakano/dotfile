require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
    },
    cwd_target = {
      sidebar = "cwd",
      current = "cwd",
    },
    follow_current_file = {
      enabled = true,
    },
  },
})
