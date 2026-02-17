return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  opts = {
    -- Use gcc to comment line, gc to comment selection
    toggler = {
      line = 'gcc',
      block = 'gbc',
    },
    opleader = {
      line = 'gc',
      block = 'gb',
    },
  },
}
