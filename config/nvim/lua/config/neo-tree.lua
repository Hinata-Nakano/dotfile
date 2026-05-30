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
