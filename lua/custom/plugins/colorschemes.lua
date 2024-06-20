return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {
      transparent_background = true,
      -- dim_inactive = {
      --   enabled = true, -- dims the background color of inactive window
      --   shade = 'light',
      --   percentage = 0.50, -- percentage of the shade to apply to the inactive window
      -- },
      default_integrations = false,
      integrations = {
        alpha = false,
        barbecue = false,
        dashboard = false,
        flash = false,
        neogit = false,
        illuminate = false,
        indent_blankline = { enabled = false },
        cmp = true,
        gitsigns = true,
        mason = true,
        markdown = true,
        mini = { enabled = true },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
        fidget = true,
        harpoon = true,
        neotest = true,
        nvimtree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        -- ufo = true, -- uncomment after trying out this plugin
      },
    },
    init = function()
      vim.cmd.colorscheme 'catppuccin-frappe'
    end,
  },

  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   config = function()
  --     require('tokyonight').setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       style = 'storm', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  --       transparent = true, -- Enable this to disable setting the background color
  --       terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  --       styles = {
  --         -- Style to be applied to different syntax groups
  --         -- Value is any valid attr-list value for `:help nvim_set_hl`
  --         comments = { italic = false },
  --         keywords = { italic = false },
  --         -- Background styles. Can be "dark", "transparent" or "normal"
  --         sidebars = 'dark', -- style for sidebars, see below
  --         floats = 'dark', -- style for floating windows
  --       },
  --     }
  --   end,
  --   init = function()
  --     vim.cmd.colorscheme 'tokyonight'
  --   end,
  -- },
}
