return {
  'olimorris/persisted.nvim',
  enabled = false,
  lazy = false, -- make sure the plugin is always loaded at startup
  opts = {
    autoload = true,
    use_git_branch = true,
  },
}
