---@param types string[] Will return the first node that matches one of these types
---@param node TSNode|nil
---@return TSNode|nil
local function find_node_ancestor(types, node)
  if not node then
    return nil
  end

  if vim.tbl_contains(types, node:type()) then
    return node
  end

  local parent = node:parent()

  return find_node_ancestor(types, parent)
end

---When typing "await" add "async" to the function declaration if the function
---isn't async already.
local function add_async()
  -- This function should be executed when the user types "t" in insert mode,
  -- but "t" is not inserted because it's the trigger.
  vim.api.nvim_feedkeys('t', 'n', true)

  local buffer = vim.fn.bufnr()

  local text_before_cursor = vim.fn.getline('.'):sub(vim.fn.col '.' - 4, vim.fn.col '.' - 1)
  if text_before_cursor ~= 'awai' then
    return
  end

  -- ignore_injections = false makes this snippet work in filetypes where JS is injected
  -- into other languages
  local current_node = vim.treesitter.get_node { ignore_injections = false }
  local function_node = find_node_ancestor({ 'arrow_function', 'function_declaration', 'function' }, current_node)
  if not function_node then
    return
  end

  local function_text = vim.treesitter.get_node_text(function_node, 0)
  if vim.startswith(function_text, 'async') then
    return
  end

  local start_row, start_col = function_node:start()
  vim.api.nvim_buf_set_text(buffer, start_row, start_col, start_row, start_col, { 'async ' })
end

vim.keymap.set('i', 't', add_async, { buffer = true })

local Mappings = {}

Mappings.config = function(bufnr)
  vim.keymap.set('n', ']u', "<cmd>lua require('neotest').jump.next({ status = 'failed' })<cr>", {
    buffer = bufnr,
    desc = 'next failed [u]nit test',
  })
  vim.keymap.set('n', '[u', "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<cr>", {
    buffer = bufnr,
    desc = 'previous failed [u]nit test',
  })

  vim.keymap.set(
    'n',
    '<leader>cp',
    "yiwOconst t0 = performance.now();<ESC>oconst t1 = performance.now();<ESC>oconsole.log(`%c <ESC>pa call took ${t1 - t0} milliseconds`, 'font-size: 24px; color: green;');<ESC>dkp",
    {
      buffer = bufnr,
      desc = '[p]erformance console.log',
    }
  )

  require('which-key').add {
    { '<leader>u', desc = '[u]nit tests', icon = '󰙨' },
  }
  vim.keymap.set('n', '<leader>ur', function()
    vim.cmd "lua require('neotest').output_panel.clear()"
    vim.cmd "lua require('neotest').run.run()"
  end, {
    buffer = bufnr,
    desc = '[r]un nearest',
  })
  vim.keymap.set('n', '<leader>uf', function()
    vim.cmd "lua require('neotest').output_panel.clear()"
    vim.cmd "lua require('neotest').run.run(vim.fn.expand('%'))"
  end, {
    buffer = bufnr,
    desc = 'run [f]ile',
  })
  vim.keymap.set('n', '<leader>ul', function()
    vim.cmd "lua require('neotest').output_panel.clear()"
    vim.cmd "lua require('neotest').run.run_last()"
  end, {
    buffer = bufnr,
    desc = 'run [l]ast',
  })
  vim.keymap.set('n', '<leader>us', '<cmd>lua require("neotest").run.stop()<cr>', {
    buffer = bufnr,
    desc = '[s]top',
  })
  vim.keymap.set('n', '<leader>ut', '<cmd>lua require("neotest").summary.toggle()<cr>', {
    buffer = bufnr,
    desc = 'summary [t]ree',
  })
  vim.keymap.set('n', '<leader>uw', '<cmd>lua require("neotest").run.run({ jestCommand = "jest --watch " })<cr>', {
    buffer = bufnr,
    desc = '[w]atch',
  })
  vim.keymap.set('n', '<leader>uc', function()
    vim.cmd "lua require('neotest').summary.toggle()"
    vim.cmd "lua require('neotest').output_panel.toggle()"
  end, {
    buffer = bufnr,
    desc = '[c]ombo: summary tree + output panel',
  })
  vim.keymap.set('n', '<leader>ua', '<cmd>lua require("neotest").run.attach()<cr>', {
    buffer = bufnr,
    desc = '[a]ttach',
  })
  vim.keymap.set('n', '<leader>up', '<cmd>lua require("neotest").output_panel.toggle()<cr>', {
    buffer = bufnr,
    desc = '[p]anel toggle',
  })
  vim.keymap.set('n', '<leader>uo', '<cmd>lua require("neotest").output.open({ enter = true })<cr>', {
    buffer = bufnr,
    desc = '[o]utput',
  })
end

return Mappings
