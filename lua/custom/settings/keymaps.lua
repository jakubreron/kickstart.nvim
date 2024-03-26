-- TODO: check if needed, without autosave it can be dangerous
-- vim.keymap.set("n", "ZQ", "<cmd>qa!<CR>", { desc = "Quit all buffers without saving" })

-- definition in split
vim.keymap.set('n', '<leader>v', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', { desc = '[V]ertical Split Definition' })

vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = '[S]ave' })

vim.keymap.set('v', '.', '<cmd>normal .<CR>', { desc = '[D]ot command over visual block' })

-- paste without yank
vim.keymap.set('v', '<leader>p', '"_dP', { desc = '[P]aste without yanking' })

-- toggle eventignore
vim.keymap.set('n', 'yoe', function()
  vim.cmd('set eventignore=' .. (vim.o.eventignore == '' and 'all' or ''))
  print(vim.o.eventignore == '' and 'Do not ignore' or 'Ignore all')
end, { desc = 'Toggle eventignore' })

-- languages
vim.keymap.set('n', 'yoss', '<cmd>setlocal spell!<CR>', { desc = '[S]pelling Toggle' })
vim.keymap.set('n', 'yosp', '<cmd>setlocal spell! spelllang=pl<CR>', { desc = '[S]pelling [P]olish' })
vim.keymap.set('n', 'yose', '<cmd>setlocal spell! spelllang=en<CR>', { desc = '[S]pelling [E]nglish' })

-- TODO: check
-- diagnostics
-- ]x [x are free
-- vim.keymap.set(
-- 	"n",
-- 	"]x",
-- 	"<cmd>lua vim.diagnostic.goto_next({ float = false })<CR>",
-- 	{ desc = "Next diagnostic" }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"[x",
-- 	"<cmd>lua vim.diagnostic.goto_prev({ float = false })<CR>",
-- 	{ desc = "Prev diagnostic" }
-- )

-- save file as sudo on files that require root permission
vim.keymap.set('c', 'w!!', "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!", { desc = '[W]rite as sudo[!!]' })

-- copy to end on Y
vim.keymap.set('n', 'Y', 'y$', { desc = '[Y]ank to the end' })

-- keep it center
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")
-- vim.keymap.set("n", "J", "mzJ`z")

-- TODO: add descriptions
vim.keymap.set('n', '<A-h>', ':vertical resize +2<CR>')
vim.keymap.set('n', '<A-j>', ':resize -2<CR>')
vim.keymap.set('n', '<A-k>', ':resize +2<CR>')
vim.keymap.set('n', '<A-l>', ':vertical resize -2<CR>')

-- TODO: add descriptions
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l')

-- TODO: check and maybe uncommend
-- jumplist every 5 lines jump with j/k
-- vim.keymap.set("n", "k", 'v:count > 5 ? "m\'" .. v:count .. "k" : "k"', { expr = true })
-- vim.keymap.set("n", "j", 'v:count > 5 ? "m\'" .. v:count .. "j" : "j"', { expr = true })

-- console
vim.keymap.set('n', '<leader>cs', '<C-w>s:term<CR>', { desc = '[C]onsole [H]orizontal' })
vim.keymap.set('n', '<leader>cv', '<C-w>v:term<CR>', { desc = '[C]onsole [V]ertical' })
vim.keymap.set('n', '<leader>ct', '<cmd>silent !tmux neww tmux-sessionizer<CR>', { desc = '[C]onsole [T]mux Session' })

-- tabs
vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = '[T]ab [N]ew' })
vim.keymap.set('n', '<leader>tc', '<cmd>tabclose<CR>', { desc = '[T]ab [C]lose' })
vim.keymap.set('n', '<leader>to', '<cmd>tabonly<CR>', { desc = '[T]ab [O]nly' })
vim.keymap.set('n', '<leader>tm', ':tabmove', { desc = '[T]ab [M]ove' })
vim.keymap.set('n', '<leader>te', ":tabedit <C-r>=expand('%:p:h')<CR>/", { desc = '[T]ab [E]dit' })
vim.keymap.set('n', '<leader>tt', '<cmd>tabnew<CR><cmd>term<CR><cmd>setlocal nonumber norelativenumber<CR>', { desc = '[T]ab [T]erminal' })

-- switch to last used tab
-- vim.api.nvim_create_autocmd("TabLeave", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.api.nvim_set_vim.keymap.set(
-- 			"n",
-- 			"<leader>;",
-- 			"<cmd>tabn " .. vim.api.nvim_tabpage_get_number(0) .. "<CR>",
-- 			{ desc = "[T]ab [L]ast", noremap = true }
-- 		)
-- 	end,
-- })
