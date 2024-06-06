local luasnip = require 'luasnip'
local i = luasnip.insert_node
local fmt = require('luasnip.extras.fmt').fmt

local snippets = function()
  return {
    -- NOTE: console logs
    luasnip.snippet('cl', fmt('console.log({}){}', { i(1), i(0) })),
    luasnip.snippet('clo', fmt('console.log({{ {} }}){}', { i(1), i(0) })),
    luasnip.snippet('cls', fmt("console.log('{}'){}", { i(1), i(0) })),
    luasnip.snippet('clb', fmt("console.log('%c {}', 'font-size: 24px; color: skyblue;'){}", { i(1), i(0) })),

    -- NOTE: variables
    luasnip.snippet('cd', fmt('const {{ {} }} = {}', { i(1), i(0) })),

    -- NOTE: unit tests snippets
    luasnip.snippet('ucl', fmt('console.log(screen.debug({})){}', { i(1), i(0) })),
    luasnip.snippet(
      'ube',
      fmt(
        [[
        beforeEach(() => {{
          {}
        }})
        ]],
        { i(1) }
      )
    ),

    luasnip.snippet(
      'uae',
      fmt(
        [[
        afterEach(() => {{
          {}
        }})
        ]],
        { i(1) }
      )
    ),

    luasnip.snippet(
      'ud',
      fmt(
        [[
        describe('{}', () => {{
          {}
        }})
        ]],
        { i(1), i(0) }
      )
    ),
    luasnip.snippet(
      'ui',
      fmt(
        [[
        test('should {}', () => {{
          {}
        }})
        ]],
        { i(1), i(0) }
      )
    ),
  }
end

local filetypes = { 'javascript', 'typescript', 'typescriptreact', 'vue' }

for _, filetype in ipairs(filetypes) do
  require('luasnip.session.snippet_collection').clear_snippets(filetype)

  luasnip.add_snippets(filetype, snippets())
end
