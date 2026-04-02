return {
  'gbprod/substitute.nvim',
  opts = {},
  keys = {
    {
      's',
      function() require('substitute').operator() end,
    },
    {
      'ss',
      function() require('substitute').line() end,
    },
    {
      'S',
      function() require('substitute').eol() end,
    },
    {
      's',
      function() require('substitute').visual() end,
      mode = 'x',
    },
  },
}
