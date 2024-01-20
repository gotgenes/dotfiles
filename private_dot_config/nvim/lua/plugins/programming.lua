return {
  {
    "nvim-treesitter/playground",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    build = ":TSInstall query",
  },
  {
    "ziontee113/syntax-tree-surfer",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("config.plugins.syntax-tree-surfer").setup()
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("config.plugins.refactoring").setup()
    end,
  },
  {
    "AndrewRadev/linediff.vim",
    cmd = { "Linediff", "LinediffReset" },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.plugins.diffview")
    end,
  },
}
