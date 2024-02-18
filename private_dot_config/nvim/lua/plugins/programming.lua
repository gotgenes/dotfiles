return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "comment",
        "cpp",
        "css",
        "dockerfile",
        "dot",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "graphql",
        "html",
        "http",
        "ini",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "kotlin",
        "latex",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "mermaid",
        "ninja",
        "perl",
        "proto",
        "python",
        "query",
        "r",
        "regex",
        "rst",
        "ruby",
        "rust",
        "scss",
        "sql",
        "swift",
        "terraform",
        "thrift",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").compilers = {
        vim.fn.getenv("CC"),
        "clang",
        "gcc",
        "cc",
        "cl",
        "zig",
      }
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
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
  {
    "zbirenbaum/copilot.lua",
    opts = {
      panel = {
        enabled = true,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-.>",
        },
      },
    },
    event = "InsertEnter",
    keys = {
      { "<C-.>", desc = "Accept Copilot suggestion", mode = "i" },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    enabled = false,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        keys = {
          { "<leader>du", false },
          {
            "<leader>dT",
            function()
              require("dapui").toggle({})
            end,
            desc = "Dap UI",
          },
        },
      },
    },
    keys = {
      { "<leader>dO", false },
      {
        "<leader>dn",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dq",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
    },
  },
}
