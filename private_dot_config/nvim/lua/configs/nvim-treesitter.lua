local M = {}

local ts_configs = require('nvim-treesitter.configs')

local function set_folding()
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end

function M.setup()
  ts_configs.setup({
    ensure_installed = {
      'bash',
      'c',
      'c_sharp',
      'cmake',
      'comment',
      'cpp',
      'css',
      'dockerfile',
      'dot',
      'go',
      'gomod',
      'graphql',
      'help',
      'html',
      'http',
      'java',
      'javascript',
      'jsdoc',
      'json',
      'json5',
      'jsonc',
      'kotlin',
      'latex',
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'ninja',
      'perl',
      'python',
      'query',
      'r',
      'regex',
      'rst',
      'ruby',
      'rust',
      'scss',
      'sql',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'yaml',
    },
    indent = {
      enable = true,
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    autopairs = {
      enable = true,
    },
    matchup = {
      enable = true,
    },
  })
  set_folding()
end

return M
