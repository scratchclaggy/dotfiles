require("formatter").setup(
  {
    filetype = {
      c = {
        -- luafmt
        function()
          return {
            exe = "clang-format",
            args = {},
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)
