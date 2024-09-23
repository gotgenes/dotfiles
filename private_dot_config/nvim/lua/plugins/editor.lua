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
    "andymass/vim-matchup",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
      require("nvim-treesitter.configs").setup({
        matchup = {
          enable = true,
          disable = {},
        },
      })
    end,
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
      {
        "debugloop/telescope-undo.nvim",
        opts = {
          extensions = {
            undo = {
              side_by_side = true,
              diff_context_lines = 4,
              initial_mode = "normal",
              layout_strategy = "vertical",
              layout_config = {
                preview_height = 0.7,
              },
            },
          },
        },
        config = function(_, opts)
          require("telescope").setup(opts)
          require("telescope").load_extension("undo")
        end,
        keys = {
          {
            "<leader>su",
            function()
              require("telescope").extensions.undo.undo()
            end,
            desc = "Undo history",
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
      {
        "<leader>fr",
        function()
          LazyVim.pick.open("oldfiles", { cwd = LazyVim.root() })
        end,
        desc = "recent",
      },
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
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          spec = {
            { "<leader>e", group = "+explorer" },
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
    opts = {
      commands = {
        copy_selector = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local vals = {
            ["BASENAME"] = modify(filename, ":r"),
            ["EXTENSION"] = modify(filename, ":e"),
            ["FILENAME"] = filename,
            ["PATH (CWD)"] = modify(filepath, ":."),
            ["PATH (HOME)"] = modify(filepath, ":~"),
            ["PATH"] = filepath,
            ["URI"] = vim.uri_from_fname(filepath),
          }

          local options = vim.tbl_filter(function(val)
            return vals[val] ~= ""
          end, vim.tbl_keys(vals))
          if vim.tbl_isempty(options) then
            vim.notify("No values to copy", vim.log.levels.WARN)
            return
          end
          table.sort(options)
          vim.ui.select(options, {
            prompt = "Choose to copy to clipboard:",
            format_item = function(item)
              return ("%s: %s"):format(item, vals[item])
            end,
          }, function(choice)
            local result = vals[choice]
            if result then
              vim.notify(("Copied: `%s`"):format(result))
              vim.fn.setreg("+", result)
            end
          end)
        end,
      },
      window = {
        mappings = {
          Y = "copy_selector",
        },
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
