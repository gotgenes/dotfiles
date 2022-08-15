local M = {}

function M.setup()
  require('nvim-treesitter.configs').setup({
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
  vim.wo.foldmethod = 'expr'
  vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
end

return M
