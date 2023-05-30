local M = {}

function M.setup()
  local ts_configs = require('nvim-treesitter.configs')
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
      'ini',
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
      'mermaid',
      'ninja',
      'perl',
      'proto',
      'python',
      'query',
      'r',
      'regex',
      'rst',
      'ruby',
      'rust',
      'scss',
      'sql',
      'thrift',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'yaml',
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
end

return M
