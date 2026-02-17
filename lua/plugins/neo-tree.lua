-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Toggle file [E]xplorer' },
    { '<leader>ef', '<cmd>Neotree reveal<cr>', desc = '[E]xplorer [F]ind file' },
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = '│',
          last_indent_marker = '└',
          highlight = 'NeoTreeIndentMarker',
        },
        icon = {
          folder_closed = '󰉓',
          folder_open = '󰝰',
          folder_empty = '󰉖',
          folder_empty_open = '󰷏',
          default = '󰈚',
        },
        git_status = {
          symbols = {
            added = '+',
            modified = '~',
            deleted = '✖',
            renamed = '➜',
            untracked = '?',
            ignored = '',
            unstaged = '✗',
            staged = '✓',
            conflict = '',
          },
        },
      },
      window = {
        position = 'left',
        width = 60,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    }
  end,
}
