return {
  {
    "nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "dot",
        "ini",
        "make",
        "mermaid",
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
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          spec = {
            { "gc", group = "comment (linewise)", icon = { icon = " ", color = "cyan" }, mode = { "n" } },
            { "gb", group = "comment (blockwise)", icon = { icon = " ", color = "cyan" }, mode = { "n" } },
          },
        },
      },
    },
    opts = {
      pre_hook = function()
        require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      end,
    },
    keys = {
      { "gcc", desc = "toggle comment", mode = { "n" } },
      { "gcA", desc = "insert comment at end of current line", mode = { "n" } },
      { "gco", desc = "insert comment to the next line", mode = { "n" } },
      { "gcO", desc = "insert comment to the previous line", mode = { "n" } },
      { "gbc", desc = "toggle comment", mode = { "n" } },
      { "gc", desc = "toggle comment (linewise)", mode = { "x" } },
      { "gb", desc = "toggle comment (blockwise)", mode = { "x" } },
    },
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
          spec = {
            { "<leader>j", group = "split/join", icon = { icon = "󰩫 ", color = "blue" } },
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
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          spec = {
            { "<leader>i", group = "ai", icon = { icon = " ", color = "orange" }, mode = { "n", "v" } },
          },
        },
      },
    },
    keys = {
      { "<leader>a", false, mode = { "n", "v" } },
      { "<leader>aa", nil, mode = { "n", "v" } },
      { "<leader>ax", nil, mode = { "n", "v" } },
      { "<leader>aq", nil, mode = { "n", "v" } },
      { "<leader>ad", nil, mode = { "n", "v" } },
      { "<leader>ap", nil, mode = { "n", "v" } },
      {
        "<leader>ia",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ix",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>iq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      -- Show help actions with telescope
      { "<leader>id", LazyVim.pick("help"), desc = "Diagnostic Help (CopilotChat)", mode = { "n", "v" } },
      -- Show prompts actions with telescope
      { "<leader>ip", LazyVim.pick("prompt"), desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
    },
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
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local js_formatters = { { "biome", "prettierd", "prettier" } }
      local formatters_by_ft = {
        javascript = js_formatters,
        javascriptreact = js_formatters,
        typescript = js_formatters,
        typescriptreact = js_formatters,
      }
      local merged_formatters = vim.tbl_extend("force", opts.formatters_by_ft or {}, formatters_by_ft)
      opts.formatters_by_ft = merged_formatters
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    opts = {},
    keys = {
      {
        "<leader>gy",
        desc = "copy remote URL",
        mode = { "n", "v" },
      },
    },
  },
}
