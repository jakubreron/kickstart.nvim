vim.filetype.add {
  pattern = {
    ['%.env.*'] = 'sh',
  },
  extension = {
    tfvars = 'tf',
  },
}
