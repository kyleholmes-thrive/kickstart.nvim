-- DBT functionality for Neovim
local M = {}

-- Helper function to run DBT commands in terminal
local function run_dbt_command(cmd)
  vim.cmd('terminal dbt ' .. cmd)
end

-- Helper function to run DBT commands with current model selection
local function run_dbt_with_selection(cmd)
  -- Get current file path relative to project root
  local file_path = vim.fn.expand '%:p'
  local relative_path = vim.fn.fnamemodify(file_path, ':.')

  -- Extract model name from file path (remove .sql extension)
  local model_name = vim.fn.fnamemodify(relative_path, ':t:r')

  if vim.bo.filetype == 'sql' and string.match(relative_path, 'models/') then
    run_dbt_command(cmd .. ' --select ' .. model_name)
  else
    run_dbt_command(cmd)
  end
end

-- Jump to dbt model definition from ref() call
local function goto_dbt_model()
  -- Get the current line
  local line = vim.api.nvim_get_current_line()

  -- Extract model name from ref('model_name') or ref("model_name")
  local model_name = line:match("ref%(['\"]([^'\"]+)['\"]%)")

  if not model_name then
    vim.notify("No ref() call found on current line", vim.log.levels.WARN)
    return
  end

  -- Find the dbt project root (look for dbt_project.yml)
  local project_root = vim.fn.findfile('dbt_project.yml', '.;')
  if project_root == '' then
    vim.notify("Could not find dbt_project.yml", vim.log.levels.ERROR)
    return
  end

  local project_dir = vim.fn.fnamemodify(project_root, ':h')

  -- Search for the model file in the models directory
  local find_cmd = string.format(
    "find '%s/models' -type f -name '%s.sql' 2>/dev/null",
    project_dir,
    model_name
  )

  local files = vim.fn.systemlist(find_cmd)

  if #files == 0 then
    vim.notify(string.format("Model '%s' not found", model_name), vim.log.levels.WARN)
  elseif #files == 1 then
    vim.cmd('edit ' .. files[1])
  else
    -- Multiple files found, let user choose
    vim.ui.select(files, {
      prompt = string.format("Multiple matches for '%s':", model_name),
    }, function(choice)
      if choice then
        vim.cmd('edit ' .. choice)
      end
    end)
  end
end

-- Setup DBT keymaps
function M.setup_keymaps()
  -- DBT Command Keymaps
  vim.keymap.set('n', '<leader>db', function()
    run_dbt_with_selection 'build'
  end, { desc = '[D]bt [B]uild current model' })
  vim.keymap.set('n', '<leader>dt', function()
    run_dbt_with_selection 'test'
  end, { desc = '[D]bt [T]est current model' })
  vim.keymap.set('n', '<leader>dc', function()
    run_dbt_with_selection 'compile'
  end, { desc = '[D]bt [C]ompile current model' })
end

-- Setup SQL-specific keymaps
function M.setup_sql_keymaps()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'sql',
    callback = function()
      -- Jump to model definition (overrides default gd in SQL files)
      vim.keymap.set('n', 'gd', goto_dbt_model, {
        buffer = true,
        desc = 'Go to dbt model definition'
      })
    end,
  })
end

-- Setup DBT snippets for SQL files
function M.setup_sql_snippets()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'sql',
    callback = function()
      -- Source snippet
      vim.keymap.set('i', '__s', [[{{ source('', '') }}]], { buffer = true, desc = 'DBT source reference' })
      -- Ref snippet
      vim.keymap.set('i', '__r', [[{{ ref('') }}]], { buffer = true, desc = 'DBT ref function' })
      -- Variable snippet
      vim.keymap.set('i', '__v', [[{{ var('') }}]], { buffer = true, desc = 'DBT variable reference' })
      -- This snippet
      vim.keymap.set('i', '__t', [[{{ this }}]], { buffer = true, desc = 'DBT this reference' })
      -- Config snippet
      vim.keymap.set(
        'i',
        '__c',
        [[{{
    config(
        materialized='view'
    )
}}]],
        { buffer = true, desc = 'DBT config block' }
      )
      -- Where block snippet
      vim.keymap.set(
        'i',
        '__w',
        [[where 1=1 
    and ]],
        { buffer = true, desc = 'where block' }
      )
      -- group by all snippet
      vim.keymap.set('i', '__g', [[group by all]], { buffer = true, desc = 'group by all' })
      -- date to month snippet
      vim.keymap.set('i', '__d', [[date_trunc('month', )::date]], { buffer = true, desc = 'Conver date to month' })
      -- convert timezone snippet
      vim.keymap.set('i', '__tz', [[convert_timezone('America/Los_Angeles', '')::timestamp_tz]], { buffer = true, desc = 'Convert timestamp to PT timezone_tz' })
    end,
  })
end

-- Main setup function
function M.setup()
  M.setup_keymaps()
  M.setup_sql_keymaps()
  M.setup_sql_snippets()
end

return M
