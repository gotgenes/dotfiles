return {
  { 'tpope/vim-fugitive' },
  { 'knsh14/vim-github-link' },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('configs.plugins.gitsigns').setup()
    end,
  },
}