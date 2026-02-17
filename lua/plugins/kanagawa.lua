-- Kanagawa colorscheme for Neovim
-- https://github.com/rebelot/kanagawa.nvim
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
    theme = 'dragon', -- wave, dragon, lotus
    background = {
      dark = 'dragon',
      light = 'lotus',
    },
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = 'none',
            bg = '#282828', -- Add this line to override the main background
          },
        },
      },
    },
    overrides = function(colors)
      return {
        Normal = { bg = '#282828' }, -- Override Normal background
        NormalFloat = { bg = '#282828' }, -- Override floating windows
        NormalNC = { bg = '#282828' }, -- Override non-current windows
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
