return {
  {
    'tpope/vim-obsession', -- save the session
    lazy = true,
    cmd = { 'Obsession' },
    keys = {
      { '<leader>ot', '<cmd>Obsession<cr>', desc = '[t]rack session' },
      { '<leader>oT', ':Obsession Session-.vim<Left><Left><Left><Left>', desc = '[T]rack custom session' },
      { '<leader>os', '<cmd>source Session.vim<cr>', desc = '[s]ource session' },
      { '<leader>oS', ':source Session-', desc = '[S]ource custom session' },
    },
    event = 'SessionLoadPost',
  },
}
