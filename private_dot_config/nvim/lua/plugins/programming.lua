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
    "echasnovski/mini.comment",
    enabled = false,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
      pre_hook = function()
        require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      end,
    },
    keys = {
      { "gc", desc = "+comment (linewise)", mode = { "n" } },
      { "gcc", desc = "toggle comment", mode = { "n" } },
      { "gcA", desc = "insert comment at end of current line", mode = { "n" } },
      { "gco", desc = "insert comment to the next line", mode = { "n" } },
      { "gcO", desc = "insert comment to the previous line", mode = { "n" } },
      { "gb", desc = "+comment (blockwise)", mode = { "n" } },
      { "gbc", desc = "toggle comment", mode = { "n" } },
      { "gc", desc = "toggle comment (linewise)", mode = { "x" } },
      { "gb", desc = "toggle comment (blockwise)", mode = { "x" } },
    },
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
    opts = {},
    keys = {
      {
        "J",
        "<cmd>STSSelectNextSiblingNode<CR>",
        desc = "select next sibling",
        mode = { "x" },
      },
      {
        "K",
        "<cmd>STSSelectPrevSiblingNode<CR>",
        desc = "select previous sibling",
        mode = { "x" },
      },
      {
        "H",
        "<cmd>STSSelectParentNode<CR>",
        desc = "select parent node",
        mode = { "x" },
      },
      {
        "L",
        "<cmd>STSSelectChildNode<CR>",
        desc = "select child node",
        mode = { "x" },
      },
    },
  },
  {
    "Wansmer/treesj",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          defaults = {
            ["<leader>j"] = { name = "+split/join" },
          },
        },
      },
    },
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      {
        "<leader>jj",
        function()
          require("treesj").join()
        end,
        desc = "join",
      },
      {
        "<leader>js",
        function()
          require("treesj").split()
        end,
        desc = "split",
      },
      {
        "<leader>jt",
        function()
          require("treesj").toggle()
        end,
        desc = "toggle join",
      },
      {
        "<leader>jT",
        function()
          require("treesj").toggle({ split = { recursive = true } })
        end,
        desc = "toggle join recursive",
      },
    },
    cmd = {
      "TSJJoin",
      "TSJSplit",
      "TSJToggle",
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "Refactor" },
    keys = {
      {
        "<leader>rb",
        function()
          require("refactoring").refactor("Extract Block")
        end,
        desc = "extract block",
        mode = { "n" },
      },
      {
        "<leader>rB",
        function()
          require("refactoring").refactor("Extract Block To File")
        end,
        desc = "extract block to file",
        mode = { "n" },
      },
      {
        "<leader>rf",
        function()
          require("refactoring").refactor("Extract Function")
        end,
        desc = "extract function",
        mode = { "x" },
      },
      {
        "<leader>rF",
        function()
          require("refactoring").refactor("Extract Function To File")
        end,
        desc = "extract function to file",
        mode = { "x" },
      },
      {
        "<leader>ri",
        function()
          require("refactoring").refactor("Inline Variable")
        end,
        desc = "inline variable",
        mode = { "n", "x" },
      },
      {
        "<leader>rI",
        function()
          require("refactoring").refactor("Inline Function")
        end,
        desc = "inline function",
        mode = { "n" },
      },
      {
        "<leader>rv",
        function()
          require("refactoring").refactor("Extract Variable")
        end,
        desc = "extract variable",
        mode = { "x" },
      },
      {
        "<leader>rr",
        function()
          require("refactoring").select_refactor({ show_success_message = true })
        end,
        desc = "select refactoring",
        mode = { "x" },
      },
    },
  },
  {
    "AndrewRadev/linediff.vim",
    cmd = { "Linediff", "LinediffReset" },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewLog",
      "DiffviewOpen",
      "DiffviewRefresh",
      "DiffviewToggleFiles",
    },
    opts = {
      view = {
        default = {
          layout = "diff2_vertical",
        },
        merge_tool = {
          layout = "diff3_vertical",
        },
        file_history = {
          layout = "diff2_vertical",
        },
      },
      enhanced_diff_hl = true,
      hooks = {
        diff_buf_read = function()
          vim.opt_local.foldlevel = 99
          vim.opt_local.foldenable = false
        end,
        diff_buf_win_enter = function()
          vim.opt_local.foldlevel = 99
          vim.opt_local.foldenable = false
        end,
      },
    },
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
