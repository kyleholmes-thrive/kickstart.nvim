return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    lazygit = { enabled = true },
    notifier = { enabled = true },
    dashboard = {
      width = 70,
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { icon = ' ', title = 'Recent Files', section = 'recent_files', limit = 10, indent = 2, padding = 1 },
        { section = 'startup' },
        {
          pane = 2,
          icon = ' ',
          title = 'Git Status',
          section = 'terminal',
          cmd = 'git status --short --branch --renames',
          height = 8,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
        },
        {
          pane = 2,
          icon = ' ',
          title = 'Recent Commits',
          section = 'terminal',
          cmd = 'git log --oneline --decorate --graph -10',
          height = 12,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
        },
        {
          pane = 2,
          icon = ' ',
          title = 'Changed Files',
          section = 'terminal',
          cmd = 'git --no-pager diff --stat -B -M -C',
          height = 8,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
        },
      },
    },
    picker = {
      sources = {
        buffers = {
          win = {
            input = {
              keys = {
                ['<c-d>'] = { 'bufdelete', mode = { 'n', 'i' } },
              },
            },
          },
        },
      },
    },
  },
  keys = {
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'LazyGit' },
    {
      '<leader>sf',
      function()
        local ok = pcall(Snacks.picker.git_files)
        if not ok then
          Snacks.picker.files()
        end
      end,
      desc = '[S]earch [F]iles',
    },
    { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eymaps' },
    { '<leader>ss', function() Snacks.picker.pickers() end, desc = '[S]earch [S]elect Picker' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch current [W]ord' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = '[S]earch by [G]rep' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[S]earch [D]iagnostics' },
    { '<leader>sr', function() Snacks.picker.resume() end, desc = '[S]earch [R]esume' },
    { '<leader>s.', function() Snacks.picker.recent() end, desc = '[S]earch Recent Files' },
    { '<leader><leader>', function() Snacks.picker.buffers() end, desc = '[ ] Find existing buffers' },
    { '<leader>/', function() Snacks.picker.lines() end, desc = '[/] Fuzzily search in current buffer' },
    { '<leader>s/', function() Snacks.picker.grep_buffers() end, desc = '[S]earch [/] in Open Files' },
    { '<leader>sn', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = '[S]earch [N]eovim files' },
    { '<leader>sN', function() Snacks.notifier.show_history() end, desc = '[S]earch [N]otification history' },
  },
}
