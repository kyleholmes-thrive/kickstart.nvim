return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    keywordStyle = { italic = false },
    statementStyle = { bold = false },
    transparent = false,
    dimInactive = false,
    terminalColors = true,
    theme = 'dragon',
    background = {
      dark = 'dragon',
      light = 'lotus',
    },
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = 'none',
            bg = '#282828',
          },
        },
      },
    },
    overrides = function(colors)
      return {
        Normal = { bg = '#282828' },
        NormalFloat = { bg = '#282828' },
        NormalNC = { bg = '#282828' },
        CursorLine = { bg = colors.palette.waveBlue1 },
        Search = { bg = colors.palette.oniViolet, fg = colors.palette.sumiInk0 },
      }
    end,
  },
  config = function(_, opts)
    require('kanagawa').setup(opts)
    vim.cmd.colorscheme 'kanagawa-dragon'
  end,
}
