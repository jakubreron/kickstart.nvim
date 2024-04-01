local M = {}

local obsession_status_icons = { '', '' }

M.config = function()
  local status_ok, lualine = pcall(require, 'lualine')
  if not status_ok then
    return
  end

  lualine.setup {
    style = 'default',
    options = {
      theme = 'auto',
      globalstatus = true,
      icons_enabled = vim.g.have_nerd_font,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = {
        {
          '',
          type = 'stl',
          color = { fg = '#7fff00' },
          cond = function()
            local status = vim.api.nvim_call_function('ObsessionStatus', obsession_status_icons)
            return status == obsession_status_icons[1]
          end,
        },
        {
          '',
          type = 'stl',
          color = { fg = '#ff6955' },
          cond = function()
            local status = vim.api.nvim_call_function('ObsessionStatus', obsession_status_icons)
            return status == obsession_status_icons[2] or status == nil or status == ''
          end,
        },
        'filename',
        function()
          return require('package-info').get_status()
        end,
      },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  }
end

return M
