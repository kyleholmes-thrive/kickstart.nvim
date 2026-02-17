return {
  'stevearc/oil.nvim',
  lazy = false,
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    float = {
      padding = 2,
      max_width = 90,
      max_height = 30,
      border = 'rounded',
      win_options = {
        winblend = 0,
      },
    },
  },
  dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
  keys = {
    { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
    { '<leader>-', '<CMD>Oil --float<CR>', desc = 'Open parent directory (floating)' },
  },
}
