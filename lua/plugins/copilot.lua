return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      panel = {
        enabled = false, -- We'll use inline suggestions only
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75, -- Lower = more frequent suggestions (default is 75ms)
        keymap = {
          accept = '<C-y>',
          accept_word = '<C-Right>',
          accept_line = '<C-Down>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-e>',
        },
      },
      filetypes = {
        ['*'] = false,
        lua = true,
        python = true,
        sql = true,
        yaml = true,
        json = true,
      },
      copilot_node_command = 'node', -- Node.js version must be > 18.x
      server_opts_overrides = {
        -- These settings can increase suggestion frequency
        inlineSuggestCount = 3, -- Request more suggestions from the server
      },
    }
  end,
}
