return {
  'sindrets/diffview.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open [g]it [d]iff view' },
    { '<leader>gc', '<cmd>DiffviewClose<cr>', desc = '[g]it diff view [c]lose' },
    { '<leader>gh', '<cmd>DiffviewFileHistory<cr>', desc = '[g]it file [h]istory' },
  },
  opts = {},
}
