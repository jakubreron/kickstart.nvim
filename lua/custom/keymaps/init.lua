local harpoon_status_ok, harpoon = pcall(require, 'harpoon')

if harpoon_status_ok then
  -- REQUIRED
  harpoon:setup()
  -- REQUIRED

  vim.keymap.set('n', '<C-f>', function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, {
    desc = 'Toggle harpoon quick menu',
  })

  vim.keymap.set('n', '<C-b>', function()
    harpoon:list():append()
  end, {
    desc = 'Add file to harpoon',
  })

  vim.keymap.set('n', ']h', function()
    harpoon:list():next()
  end, {
    desc = 'Next harpoon file',
  })

  vim.keymap.set('n', '[h', function()
    harpoon:list():prev()
  end, {
    desc = 'Prev harpoon file',
  })

  for i = 1, 6 do
    vim.keymap.set('n', '<leader>' .. i, function()
      harpoon:list():select(i)
    end, { desc = 'Mark ' .. i })
  end
end

vim.keymap.set('n', 'ZQ', '<cmd>qa<CR>', { desc = 'Quit all buffers' })

vim.keymap.set('n', '<leader>v', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', { desc = '[V]ertical Split Definition' })

vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = '[S]ave' })

vim.keymap.set('v', '.', '<cmd>normal .<CR>', { desc = '[D]ot command over visual block' })

vim.keymap.set('v', '<leader>p', '"_dP', { desc = '[P]aste without yanking' })

vim.keymap.set('n', 'yoe', function()
  vim.cmd('set eventignore=' .. (vim.o.eventignore == '' and 'all' or ''))
  print(vim.o.eventignore == '' and '[E]ventignore OFF' or '[E]ventignore ON')
end, { desc = '[E]ventignore' })

vim.keymap.set('n', 'yoss', '<cmd>setlocal spell!<CR>', { desc = '[S]pelling Toggle' })
vim.keymap.set('n', 'yosp', '<cmd>setlocal spell! spelllang=pl<CR>', { desc = '[P]olish' })
vim.keymap.set('n', 'yose', '<cmd>setlocal spell! spelllang=en<CR>', { desc = '[E]nglish' })

vim.keymap.set('c', 'w!!', "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!", { desc = '[W]rite as sudo[!!]' })

vim.keymap.set('n', 'Y', 'y$', { desc = '[Y]ank to the end' })

vim.keymap.set('n', '<A-h>', ':vertical resize +2<CR>')
vim.keymap.set('n', '<A-j>', ':resize -2<CR>')
vim.keymap.set('n', '<A-k>', ':resize +2<CR>')
vim.keymap.set('n', '<A-l>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize +2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>')
vim.keymap.set('n', '<A-Right>', ':vertical resize -2<CR>')

vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l')

vim.keymap.set('n', '<leader>cs', '<C-w>s:term<CR>', { desc = '[H]orizontal' })
vim.keymap.set('n', '<leader>cv', '<C-w>v:term<CR>', { desc = '[V]ertical' })
vim.keymap.set('n', '<leader>ct', '<cmd>silent !tmux neww tmux-sessionizer<CR>', { desc = '[T]mux Session' })

vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = '[N]ew' })
vim.keymap.set('n', '<leader>tc', '<cmd>tabclose<CR>', { desc = '[C]lose' })
vim.keymap.set('n', '<leader>to', '<cmd>tabonly<CR>', { desc = '[O]nly' })
vim.keymap.set('n', '<leader>tm', ':tabmove', { desc = '[M]ove' })
vim.keymap.set('n', '<leader>te', ":tabedit <C-r>=expand('%:p:h')<CR>/", { desc = '[E]dit' })
vim.keymap.set('n', '<leader>tt', '<cmd>tabnew<CR><cmd>term<CR><cmd>setlocal nonumber norelativenumber<CR>', { desc = '[T]erminal' })

vim.keymap.set('n', '<leader>pl', '<cmd>Lazy<cr>', { desc = '[L]azy' })
vim.keymap.set('n', '<leader>pi', '<cmd>Lazy install<cr>', { desc = '[I]nstall' })
vim.keymap.set('n', '<leader>ps', '<cmd>Lazy sync<cr>', { desc = '[S]ync' })
vim.keymap.set('n', '<leader>pp', '<cmd>Lazy profile<cr>', { desc = '[P]rofile' })
vim.keymap.set('n', '<leader>pr', '<cmd>Lazy restore<cr>', { desc = '[R]estore' })
