local ls = require 'luasnip'
local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
-- local fmta = require('luasnip.extras.fmt').fmta
-- local rep = require('luasnip.extras').rep

return {
  s({
    trig = ';f',
    dscr = 'Arrow function',
    snippetType = 'autosnippet',
  }, fmt('const {} = ({}) => {}', { i(1), i(2), i(3) })),
  s(
    { trig = 'switch' },
    fmt(
      [[switch ({}) {{
  case {}:
    {}
    break;
  default:
    break;
}}]],
      { i(1), i(2), i(3) }
    )
  ),
}
