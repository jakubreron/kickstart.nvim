local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

local obsession_status_icons = { '', '' }
local obsession_status_colors = {
  tracking = '#7fff00',
  not_tracking = '#ff6955',
}

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
        color = { fg = obsession_status_colors.tracking },
        cond = function()
          local obsession_status_ok, obsession_status = pcall(vim.api.nvim_call_function, 'ObsessionStatus', obsession_status_icons)

          if not obsession_status_ok then
            return false
          end

          return obsession_status == obsession_status_icons[1]
        end,
      },
      {
        '',
        type = 'stl',
        color = { fg = obsession_status_colors.not_tracking },
        cond = function()
          local obsession_status_ok, obsession_status = pcall(vim.api.nvim_call_function, 'ObsessionStatus', obsession_status_icons)

          if not obsession_status_ok then
            return true
          end

          return obsession_status == obsession_status_icons[2] or obsession_status == nil or obsession_status == ''
        end,
      },
      'filename',
      function()
        if string.find(vim.fn.expand '%:p', 'package.json') ~= nil then
          return require('package-info').get_status()
        else
          return ''
        end
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
