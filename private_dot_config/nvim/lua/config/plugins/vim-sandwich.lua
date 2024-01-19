local M = {}

local function set_recipes()
  local recipes = vim.deepcopy(vim.g['sandwich#default_recipes'])
  local new_recipes = {
    {
      buns = { '{ ', ' }' },
      nesting = 1,
      match_syntax = 1,
      kind = { 'add', 'replace' },
      action = { 'add' },
      input = { '{' },
    },
    {
      buns = { '[ ', ' ]' },
      nesting = 1,
      match_syntax = 1,
      kind = { 'add', 'replace' },
      action = { 'add' },
      input = {
        '[',
      },
    },
    {
      buns = { '( ', ' )' },
      nesting = 1,
      match_syntax = 1,
      kind = { 'add', 'replace' },
      action = { 'add' },
      input = {
        '(',
      },
    },
    {
      buns = { '{s*', 's*}' },
      nesting = 1,
      regex = 1,
      match_syntax = 1,
      kind = { 'delete', 'replace', 'textobj' },
      action = { 'delete' },
      input = { '{' },
    },
    {
      buns = { '[s*', 's*]' },
      nesting = 1,
      regex = 1,
      match_syntax = 1,
      kind = { 'delete', 'replace', 'textobj' },
      action = { 'delete' },
      input = { '[' },
    },
    {
      buns = { '(s*', 's*)' },
      nesting = 1,
      regex = 1,
      match_syntax = 1,
      kind = { 'delete', 'replace', 'textobj' },
      action = { 'delete' },
      input = { '(' },
    },
  }

  vim.list_extend(recipes, new_recipes)
  vim.g['sandwich#recipes'] = recipes
end

local function set_keymaps()
  local wk = require('which-key')
  wk.register({
    a = {
      name = 'Surround (sandwich)',
      {
        a = { '<Plug>(sandwich-add)', 'add', mode = { 'n', 'x', 'o' } },
        d = { '<Plug>(sandwich-delete)', 'delete' },
        r = { '<Plug>(sandwich-replace)', 'replace' },
      },
    },
  }, {
    mode = { 'n', 'x' },
    prefix = '<leader>',
    remap = true,
  })
  wk.register({
    d = {
      b = { '<Plug>(sandwich-delete-auto)', 'delete (auto)' },
    },
    r = {
      b = { '<Plug>(sandwich-replace-auto)', 'replace (auto)' },
    },
  }, {
    mode = 'n',
    prefix = '<leader>a',
    remap = true,
  })
end

function M.setup()
  set_recipes()
  set_keymaps()
end

return M
