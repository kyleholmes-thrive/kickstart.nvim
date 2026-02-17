return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()

    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_filename = function()
      local filename = vim.fn.expand '%:t'
      if filename == '' then
        filename = '[No Name]'
      end
      if vim.bo.modified then
        filename = filename .. ' ●'
      end
      return filename
    end
  end,
}
