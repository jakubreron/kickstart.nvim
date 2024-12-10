return {
  {
    'nat-418/boole.nvim',
    lazy = true,
    opts = {
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>',
      },
      additions = {
        { 'child', 'parent' },
        { 'toBeTruthy', 'toBeFalsy' },
        { 'toBeEnabled', 'toBeDisabled' },
        { 'left', 'center', 'right' },
        { 'light', 'dark' },
      },
      allow_caps_additions = {
        { 'enable', 'disable' },
        -- enable → disable
        -- Enable → Disable
        -- ENABLE → DISABLE
      },
    },
    keys = {
      '<C-a>',
      '<C-x>',
    },
  },
}
