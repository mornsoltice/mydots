return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "meuter/lualine-so-fancy.nvim",
  },
  enabled = true,
  lazy = false,
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {
            "alpha-nvim",
            "help",
            "neo-tree",
            "Trouble",
            "spectre_panel",
            "toggleterm",
          },
          winbar = {},
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {
          -- Displaying branch information
          "fancy_branch",
        },
        lualine_c = {
          {
            -- Displaying filename and its status
            "filename",
            path = 1, -- Set to 1 for relative path, 2 for full path
            symbols = {
              modified = "  ", -- Modified symbol
              readonly = "  ",  -- Read-only symbol
              unnamed = "  ",  -- Unnamed file symbol
            },
          },
          {
            -- Diagnostics with LSP symbols
            "fancy_diagnostics",
            sources = { "nvim_lsp" },
            symbols = {
              error = " ", -- Error icon
              warn = " ",  -- Warning icon
              info = " ",  -- Info icon
            },
          },
          -- Search count (matches the number of searches)
          { "fancy_searchcount" },
        },
        lualine_x = {
          -- Displaying the current active LSP server(s)
          "fancy_lsp_servers",
          -- Displaying git diff status
          "fancy_diff",
          -- Progress indicator (line and column numbers)
          "progress",
        },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        -- Configuration for inactive windows
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          -- Show filename only
          "filename",
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "neo-tree", "lazy" }, -- Using extensions for specific windows
    })
  end,
}
