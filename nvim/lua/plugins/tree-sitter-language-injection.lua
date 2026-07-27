vim.pack.add { { src = Gh 'DariusCorvus/tree-sitter-language-injection.nvim' } }

require('tree-sitter-language-injection').setup {}

vim.treesitter.query.set(
  'typescript',
  'injections',
  [[
  ((comment) @comment
    .
    [
      (lexical_declaration
        (variable_declarator
          value: (template_string (string_fragment) @injection.content)))
      (pair
        value: (template_string (string_fragment) @injection.content))
    ]
    (#eq? @comment "// language=cedar")
    (#set! injection.language "cedar"))
]]
)
