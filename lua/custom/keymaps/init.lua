vim.keymap.set({ 'n', 'v' }, 'ZQ', '<cmd>qa<cr>', { desc = 'quit all buffers' })

vim.keymap.set('n', '<leader>v', '<cmd>vsplit | lua vim.lsp.buf.definition()<cr>', { desc = '[v]ertical split definition' })

vim.keymap.set({ 'n', 'v', 'i' }, '<C-s>', '<esc><cmd>w<cr>', { desc = '[s]ave' })

vim.keymap.set('n', 'p', ']p', { desc = '[p]aste' })

vim.keymap.set('v', '.', '<cmd>normal .<cr>', { desc = '[d]ot command over visual block' })

vim.keymap.set('v', '<leader>p', '"_dP', { desc = '[p]aste without yanking' })

vim.keymap.set('t', '<C-\\><C-n>', '<C-\\><C-n>0', { desc = 'exit terminal mode' })

-- NOTE: toggle
vim.keymap.set('n', 'yoe', function()
  vim.cmd('set eventignore=' .. (vim.o.eventignore == '' and 'all' or ''))
  print(vim.o.eventignore == '' and 'Eventignore OFF' or 'Eventignore ON')
end, { desc = '[e]ventignore' })
vim.keymap.set('n', 'yor', '<cmd>setlocal relativenumber!<cr>', { desc = '[r]elativenumber toggle' })
vim.keymap.set('n', 'yow', '<cmd>setlocal wrap!<cr>', { desc = '[w]rap toggle' })
vim.keymap.set('n', 'yoss', '<cmd>setlocal spell!<cr>', { desc = '[s]pelling toggle' })
vim.keymap.set('n', 'yosp', '<cmd>setlocal spell! spelllang=pl<cr>', { desc = '[p]olish' })
vim.keymap.set('n', 'yose', '<cmd>setlocal spell! spelllang=en<cr>', { desc = '[e]nglish' })

vim.keymap.set('n', 'gO', "<cmd>call append(line('.') - 1, repeat([''], v:count1))<cr>", { desc = '[O] blank space up' })
vim.keymap.set('n', 'go', "<cmd>call append(line('.'),     repeat([''], v:count1))<cr>", { desc = '[o] blank space down' })

-- NOTE: center search matches
vim.keymap.set('n', 'n', 'nzzzv', { silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { silent = true })
vim.keymap.set('n', 'J', 'mzJ`z', { silent = true })

-- NOTE: jumplist every 5 lines jump with j/k
vim.keymap.set('n', 'k', 'v:count > 5 ? "m\'" .. v:count .. "k" : "k"', { expr = true, silent = true })
vim.keymap.set('n', 'j', 'v:count > 5 ? "m\'" .. v:count .. "j" : "j"', { expr = true, silent = true })

vim.keymap.set('c', 'w!!', 'execute "silent! write !sudo tee % >/dev/null" <bar> edit!', { desc = '[w]rite as sudo[!!]' })

-- NOTE: emacs keybinds in command/insert mode
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')
vim.keymap.set('c', '<C-f>', '<Right>')
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<C-d>', '<Delete>')
vim.keymap.set('c', '<A-f>', '<C-Right>')
vim.keymap.set('c', '<A-b>', '<C-Left>')

vim.keymap.set('n', 'Y', 'y$', { desc = '[Y]ank to the end' })

-- NOTE: resize splits
vim.keymap.set('n', '<A-h>', ':vertical resize +2<cr>', { silent = true })
vim.keymap.set('n', '<A-j>', ':resize -2<cr>', { silent = true })
vim.keymap.set('n', '<A-k>', ':resize +2<cr>', { silent = true })
vim.keymap.set('n', '<A-l>', ':vertical resize -2<cr>', { silent = true })

-- NOTE: navigation
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l')

-- NOTE: console
vim.keymap.set('n', '<leader>cs', '<C-w>s:term<cr>', { desc = '[s]plit' })
vim.keymap.set('n', '<leader>cv', '<C-w>v:term<cr>', { desc = '[v]split' })
vim.keymap.set('n', '<leader>ct', '<cmd>tabnew<cr><cmd>term<cr><cmd>setlocal nonumber norelativenumber<cr>', { desc = '[t]tab' })
vim.keymap.set('n', '<leader>cs', '<cmd>silent !tmux neww tmux-sessionizer<cr>', { desc = 'tmux [s]ession' })

-- NOTE: tab
vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<cr>', { desc = '[n]ew' })
vim.keymap.set('n', '<leader>tc', '<cmd>tabclose<cr>', { desc = '[c]lose' })
vim.keymap.set('n', '<leader>to', '<cmd>tabonly<cr>', { desc = '[o]nly' })
vim.keymap.set('n', '<leader>tm', ':tabmove', { desc = '[m]ove' })
vim.keymap.set('n', '<leader>te', ":tabedit <C-r>=expand('%:p:h')<cr>/", { desc = '[e]dit' })

vim.api.nvim_create_autocmd('TabLeave', {
  callback = function()
    vim.api.nvim_set_keymap('n', '<leader><leader>', '<cmd>tabn ' .. vim.api.nvim_tabpage_get_number(0) .. '<cr>', { desc = '[ ] last tab' })
  end,
})

-- NOTE: lazy
vim.keymap.set('n', '<leader>ph', '<cmd>Lazy<cr>', { desc = '[h]ome' })
vim.keymap.set('n', '<leader>pi', '<cmd>Lazy install<cr>', { desc = '[i]nstall' })
vim.keymap.set('n', '<leader>ps', '<cmd>Lazy sync<cr>', { desc = '[s]ync' })
vim.keymap.set('n', '<leader>px', '<cmd>Lazy clean<cr>', { desc = '[x] clean' })
vim.keymap.set('n', '<leader>pp', '<cmd>Lazy profile<cr>', { desc = '[p]rofile' })
vim.keymap.set('n', '<leader>pr', '<cmd>Lazy restore<cr>', { desc = '[r]estore' })

-- NOTE: replace
vim.keymap.set('n', '<leader>ru', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[u]nder cursor' })

local function quickfix_toggle()
  if vim.fn.empty(vim.fn.filter(vim.fn.getwininfo(), 'v:val.quickfix')) == 1 then
    vim.cmd [[copen]]
  else
    vim.cmd [[cclose]]
  end
end

vim.keymap.set({ 'n', 'v', 'i' }, '<C-q>', quickfix_toggle, { desc = '[q]uickfix toggle', silent = true })

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
