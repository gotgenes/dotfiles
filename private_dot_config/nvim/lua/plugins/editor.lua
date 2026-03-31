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
    "saghen/blink.pairs",
    version = "*",
    dependencies = { "saghen/blink.download" },
    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {},
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
