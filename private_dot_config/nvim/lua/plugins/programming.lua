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
        "hjson",
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
      require("nvim-treesitter").setup(opts)
    end,
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
    "folke/sidekick.nvim",
    -- stylua: ignore
    opts = function()
      -- Accept inline suggestions or next edits
      LazyVim.cmp.actions.ai_nes = function()
        local Nes = require("sidekick.nes")
        if Nes.have() and (Nes.jump() or Nes.apply()) then
          return true
        end
      end
      Snacks.toggle({
        name = "Sidekick NES",
        get = function() return require("sidekick.nes").enabled end,
        set = function(state) require("sidekick.nes").enable(state) end,
      }):map("<leader>uN")
    end,
    -- stylua: ignore
    keys = {
      { "<tab>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n" }, expr = true },
      { "<c-.>", function() require("sidekick.cli").focus() end, desc = "Sidekick Focus", mode = { "n", "t", "i", "x" } },
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
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        ["neotest-vitest"] = {},
      },
    },
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
  {
    "jannis-baum/vivify.vim",
    filetype = {
      "markdown",
    },
  },
  {
    "DrKJeff16/wezterm-types",
    lazy = true,
  },
  {
    "folke/lazydev.nvim",
    opts = {
      library = {
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
  },
}
