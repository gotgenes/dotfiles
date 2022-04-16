local M = {}

function M.setup()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash',
      'c',
      'c_sharp',
      'comment',
      'cpp',
      'css',
      'dockerfile',
      'go',
      'gomod',
      'graphql',
      'help',
      'html',
      'java',
      'javascript',
      'jsdoc',
      'json',
      'json5',
      'jsonc',
      'latex',
      'lua',
      'make',
      'ninja',
      'perl',
      'python',
      'query',
      'rst',
      'ruby',
      'rust',
      'scss',
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
