return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
      },
      keymap = {
        preset = "enter",
        ["<C-y>"] = { "select_and_accept" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
      sources = {
        per_filetype = {
          codecompanion = { "codecompanion", "buffer", "path" },
        },
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    keys = {
      {
        "<C-n>",
        function()
          require("luasnip").jump(1)
        end,
        desc = "Jump to next snippet location",
        mode = { "i", "s" },
      },
      {
        "<C-p>",
        function()
          require("luasnip").jump(-1)
        end,
        desc = "Jump to previous snippet location",
        mode = { "i", "s" },
      },
      {
        "<Tab>",
        false,
        mode = { "i", "s" },
      },
      {
        "<S-Tab>",
        false,
        mode = { "i", "s" },
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      npairs.setup({
        check_ts = true,
      })

      npairs.add_rules({
        Rule(" ", " "):with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ "()", "[]", "{}" }, pair)
        end),
        Rule("( ", " )")
          :with_pair(function()
            return false
          end)
          :with_move(function(opts)
            return opts.prev_char:match(".%)") ~= nil
          end)
          :use_key(")"),
        Rule("{ ", " }")
          :with_pair(function()
            return false
          end)
          :with_move(function(opts)
            return opts.prev_char:match(".%}") ~= nil
          end)
          :use_key("}"),
        Rule("[ ", " ]")
          :with_pair(function()
            return false
          end)
          :with_move(function(opts)
            return opts.prev_char:match(".%]") ~= nil
          end)
          :use_key("]"),
      })
    end,
  },
  {
    "nvim-mini/mini.pairs",
    enabled = false,
  },
  {
    "andymass/vim-matchup",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
      require("nvim-treesitter").setup({
        matchup = {
          enable = true,
          disable = {},
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {
      modes = {
        symbols = {
          win = { position = "right", size = 80 },
        },
      },
    },
  },
  {
    "AndrewRadev/inline_edit.vim",
    cmd = { "InlineEdit" },
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      mappings = {
        i = {
          j = {
            k = "<Esc>",
            j = "<Esc>",
          },
          k = {
            j = "<Esc>",
          },
        },
        c = {
          j = {
            k = "<Esc>",
            j = "<Esc>",
          },
          k = {
            j = "<Esc>",
          },
        },
        t = {
          j = {
            k = "<Esc>",
            j = "<Esc>",
          },
          k = {
            j = "<Esc>",
          },
        },
        v = {
          j = {
            k = "<Esc>",
          },
          k = {
            j = "<Esc>",
          },
        },
        s = {
          j = {
            k = "<Esc>",
          },
          k = {
            j = "<Esc>",
          },
        },
      },
    },
  },
  { "wsdjeg/vim-fetch" },
  {
    "klen/nvim-config-local",
    opts = {},
    main = "config-local",
  },
  {
    "gpanders/editorconfig.nvim",
  },
  {
    "nvim-mini/mini.surround",
    dependencies = {
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          spec = {
            { "<leader>a", group = "+surround" },
          },
        },
      },
    },
    opts = {
      mappings = {
        add = "<leader>aa",
        delete = "<leader>ad",
        find = "<leader>af",
        find_left = "<leader>aF",
        highlight = "<leader>ah",
        replace = "<leader>ar",
        update_n_lines = "<leader>an",
      },
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
    },
  },
}
