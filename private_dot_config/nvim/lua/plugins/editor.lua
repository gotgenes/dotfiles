return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = {
        ["<Down>"] = {
          i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        },
        ["<Up>"] = {
          i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        },
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-y>"] = cmp.mapping.confirm({ select = false }),
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      }
    end,
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
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      local Rule = require("nvim-autopairs.rule")
      npairs.setup({
        check_ts = true,
      })
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

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
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "danielfalk/smart-open.nvim",
        opts = {},
        config = function()
          require("telescope").load_extension("smart_open")
        end,
        dependencies = {
          "kkharji/sqlite.lua",
          "nvim-telescope/telescope-fzy-native.nvim",
          "nvim-tree/nvim-web-devicons",
        },
        keys = {
          {
            "<leader><space>",
            function()
              require("telescope").extensions.smart_open.smart_open({ cwd_only = true })
            end,
            desc = "find files by frecency (Root Dir)",
          },
          {
            "<leader>ff",
            function()
              require("telescope").extensions.smart_open.smart_open({ cwd_only = true })
            end,
            desc = "find files by frecency (Root Dir)",
          },
        },
      },
    },
    opts = {
      defaults = {
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<c-f>"] = function(...)
              return require("telescope.actions").results_scrolling_down(...)
            end,
            ["<c-b>"] = function(...)
              return require("telescope.actions").results_scrolling_up(...)
            end,
            ["<c-u>"] = false,
            ["<c-d>"] = false,
          },
          n = {
            ["<c-f>"] = function(...)
              return require("telescope.actions").results_scrolling_down(...)
            end,
            ["<c-b>"] = function(...)
              return require("telescope.actions").results_scrolling_up(...)
            end,
            ["<c-d>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<c-u>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
          },
        },
      },
      pickers = {
        buffers = {
          theme = "dropdown",
          previewer = false,
          initial_mode = "normal",
          mappings = {
            n = {
              dd = "delete_buffer",
            },
          },
        },
      },
    },
    keys = {
      { "<leader>fr", LazyVim.telescope("oldfiles", { cwd = LazyVim.root() }), desc = "recent" },
      { "<leader>fR", "<cmd>Telescope resume<cr>", desc = "resume" },
      {
        "<leader>sG",
        function()
          require("telescope.builtin").grep_string()
        end,
        desc = "grep word under cursor",
      },
      {
        "<leader>sga",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "grep search all",
      },
      {
        "<leader>sgp",
        function()
          require("telescope.builtin").live_grep({
            glob_pattern = {
              "!*test*",
            },
          })
        end,
        desc = "grep search production (exclude test files)",
      },
      {
        "<leader>sgt",
        function()
          require("telescope.builtin").live_grep({ glob_pattern = { "*test*" } })
        end,
        "search tests",
      },
    },
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
      mapping = { "jk", "jj", "kj" },
      keys = function()
        return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<Esc>l" or "<Esc>"
      end,
    },
  },
  { "wsdjeg/vim-fetch" },
  {
    "axkirillov/hbac.nvim",
    dependencies = {
      -- these are optional, add them, if you want the telescope module
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    event = { "BufRead", "BufNewFile" },
  },
  {
    "klen/nvim-config-local",
    opts = {},
    main = "config-local",
  },
  {
    "gpanders/editorconfig.nvim",
  },
  {
    "echasnovski/mini.surround",
    dependencies = {
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          defaults = {
            ["<leader>a"] = { name = "+surround" },
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
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          defaults = {
            ["<leader>e"] = { name = "+explorer" },
          },
        },
      },
    },
    keys = function()
      return {
        {
          "<leader>ef",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
          end,
          desc = "Explorer NeoTree (root dir)",
        },
        {
          "<leader>eF",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
        {
          "<leader>eg",
          function()
            require("neo-tree.command").execute({ source = "git_status", toggle = true })
          end,
          desc = "Git explorer",
        },
        {
          "<leader>eb",
          function()
            require("neo-tree.command").execute({ source = "buffers", toggle = true })
          end,
          desc = "Buffer explorer",
        },
      }
    end,
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
