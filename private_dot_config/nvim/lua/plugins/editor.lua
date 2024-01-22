return {
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
            "<leader>sf",
            function()
              require("telescope").extensions.smart_open.smart_open({ cwd_only = true })
            end,
            desc = "search files by frecency",
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
        },
      },
    },
    keys = {
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
  { "AndrewRadev/inline_edit.vim" },
  {
    "max397574/better-escape.nvim",
    config = function()
      require("config.plugins.better-escape").setup()
    end,
  },
  { "AndrewRadev/splitjoin.vim" },
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
    "shortcuts/no-neck-pain.nvim",
    cmd = {
      "NoNeckPain",
      "NoNeckPainResize",
      "NoNeckPainWidthUp",
      "NoNeckPainWidthDown",
      "NoNeckPainScratchPad",
    },
    opts = {
      width = 130,
      buffers = {
        colors = {
          background = require("catppuccin.palettes").get_palette().crust,
        },
      },
    },
  },
}
