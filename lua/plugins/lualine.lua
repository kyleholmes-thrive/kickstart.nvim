return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'kanagawa',
      component_separators = '',
      section_separators = '',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = {
        { 'filename', symbols = { modified = ' ●', readonly = ' ' } },
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
  },
}
