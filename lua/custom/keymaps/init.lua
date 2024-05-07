local harpoon_status_ok, harpoon = pcall(require, 'harpoon')

if harpoon_status_ok then
  -- REQUIRED
  harpoon:setup()
  -- REQUIRED

  vim.keymap.set('n', '<C-f>', function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, {
    desc = 'toggle harpoon quick menu',
  })

  vim.keymap.set('n', '<C-b>', function()
    harpoon:list():add()
  end, {
    desc = 'add file to harpoon',
  })

  vim.keymap.set('n', ']h', function()
    harpoon:list():next()
  end, {
    desc = 'next [h]arpoon file',
  })

  vim.keymap.set('n', '[h', function()
    harpoon:list():prev()
  end, {
    desc = 'prev [h]arpoon file',
  })

  for i = 1, 6 do
    vim.keymap.set('n', '<leader>' .. i, function()
      harpoon:list():select(i)
    end, { desc = '[' .. i .. '] mark' })
  end
end

vim.keymap.set('n', 'ZQ', '<cmd>qa<CR>', { desc = 'quit all buffers' })

vim.keymap.set('n', '<leader>v', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', { desc = '[v]ertical split definition' })

vim.keymap.set({ 'n', 'v', 'i' }, '<C-s>', '<esc><cmd>w<CR>', { desc = '[s]ave' })

vim.keymap.set('n', 'p', ']p', { desc = '[p]aste' })

vim.keymap.set('v', '.', '<cmd>normal .<CR>', { desc = '[d]ot command over visual block' })

vim.keymap.set('v', '<leader>p', '"_dP', { desc = '[p]aste without yanking' })

vim.keymap.set('n', 'yoe', function()
  vim.cmd('set eventignore=' .. (vim.o.eventignore == '' and 'all' or ''))
  print(vim.o.eventignore == '' and 'Eventignore OFF' or 'Eventignore ON')
end, { desc = '[e]ventignore' })

vim.keymap.set('n', 'yoss', '<cmd>setlocal spell!<CR>', { desc = '[s]pelling toggle' })
vim.keymap.set('n', 'yosp', '<cmd>setlocal spell! spelllang=pl<CR>', { desc = '[p]olish' })
vim.keymap.set('n', 'yose', '<cmd>setlocal spell! spelllang=en<CR>', { desc = '[e]nglish' })

vim.keymap.set('n', 'n', 'nzzzv', { silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { silent = true })
vim.keymap.set('n', 'J', 'mzJ`z', { silent = true })

-- jumplist every 5 lines jump with j/k
vim.keymap.set('n', 'k', 'v:count > 5 ? "m\'" .. v:count .. "k" : "k"', { expr = true, silent = true })
vim.keymap.set('n', 'j', 'v:count > 5 ? "m\'" .. v:count .. "j" : "j"', { expr = true, silent = true })

vim.keymap.set('c', 'w!!', 'execute "silent! write !sudo tee % >/dev/null" <bar> edit!', { desc = '[w]rite as sudo[!!]' })

-- emacs keybinds in command/insert mode
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')
vim.keymap.set('c', '<C-f>', '<Right>')
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<C-d>', '<Delete>')
vim.keymap.set('c', '<A-f>', '<C-Right>')
vim.keymap.set('c', '<A-b>', '<C-Left>')

vim.keymap.set('n', 'Y', 'y$', { desc = '[Y]ank to the end' })

vim.keymap.set('n', '<A-h>', ':vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<A-j>', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<A-k>', ':resize +2<CR>', { silent = true })
vim.keymap.set('n', '<A-l>', ':vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize -2<CR>', { silent = true })

vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l')

vim.keymap.set('n', '<leader>cs', '<C-w>s:term<CR>', { desc = '[s]plit' })
vim.keymap.set('n', '<leader>cv', '<C-w>v:term<CR>', { desc = '[v]split' })
vim.keymap.set('n', '<leader>ct', '<cmd>tabnew<CR><cmd>term<CR><cmd>setlocal nonumber norelativenumber<CR>', { desc = '[t]tab' })
vim.keymap.set('n', '<leader>cs', '<cmd>silent !tmux neww tmux-sessionizer<CR>', { desc = 'tmux [s]ession' })

vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = '[n]ew' })
vim.keymap.set('n', '<leader>tc', '<cmd>tabclose<CR>', { desc = '[c]lose' })
vim.keymap.set('n', '<leader>to', '<cmd>tabonly<CR>', { desc = '[o]nly' })
vim.keymap.set('n', '<leader>tm', ':tabmove', { desc = '[m]ove' })
vim.keymap.set('n', '<leader>te', ":tabedit <C-r>=expand('%:p:h')<CR>/", { desc = '[e]dit' })

vim.api.nvim_create_autocmd('TabLeave', {
  callback = function()
    vim.api.nvim_set_keymap('n', '<leader><leader>', '<cmd>tabn ' .. vim.api.nvim_tabpage_get_number(0) .. '<CR>', { desc = '[ ] last tab' })
  end,
})

vim.keymap.set('n', '<leader>pl', '<cmd>Lazy<cr>', { desc = '[l]azy' })
vim.keymap.set('n', '<leader>pi', '<cmd>Lazy install<cr>', { desc = '[i]nstall' })
vim.keymap.set('n', '<leader>ps', '<cmd>Lazy sync<cr>', { desc = '[s]ync' })
vim.keymap.set('n', '<leader>pp', '<cmd>Lazy profile<cr>', { desc = '[p]rofile' })
vim.keymap.set('n', '<leader>pr', '<cmd>Lazy restore<cr>', { desc = '[r]estore' })

-- TODO: find something
-- vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
-- vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')

vim.keymap.set('n', '<leader>ru', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[u]nder cursor' })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<C-\\><C-n>', '<C-\\><C-n>0', { desc = 'Exit terminal mode' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

vim.keymap.set('n', '<C-q>', ':call QuickFixToggle()<CR>', { desc = 'Toggle [q]uickfix', silent = true })

vim.cmd [[
  function! RemoveQFItem()
    let curqfidx = line('.') - 1
    let qfall = getqflist()
    call remove(qfall, curqfidx)
    call setqflist(qfall, 'r')
    execute curqfidx + 1 . "cfirst"
    :copen
  endfunction

  :command! RemoveQFItem :call RemoveQFItem()

  autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>
]]
