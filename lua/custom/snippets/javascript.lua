local luasnip = require 'luasnip'
local i = luasnip.insert_node
local fmt = require('luasnip.extras.fmt').fmt

local snippets = function()
  return {
    luasnip.snippet('cl', fmt('console.log({}){}', { i(1), i(0) })),
    luasnip.snippet('clo', fmt('console.log({{ {} }}){}', { i(1), i(0) })),
    luasnip.snippet('cls', fmt("console.log('{}'){}", { i(1), i(0) })),
    luasnip.snippet('clb', fmt("console.log('%c {}', 'font-size: 24px; color: skyblue;'){}", { i(1), i(0) })),
  }
end

local filetypes = { 'javascript', 'typescript', 'typescriptreact', 'vue' }

for _, filetype in ipairs(filetypes) do
  require('luasnip.session.snippet_collection').clear_snippets(filetype)

  luasnip.add_snippets(filetype, snippets())
end
