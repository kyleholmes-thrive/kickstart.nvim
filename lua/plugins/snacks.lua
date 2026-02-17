return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    lazygit = { enabled = true },
  },
  keys = {
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'LazyGit' },
  },
}
