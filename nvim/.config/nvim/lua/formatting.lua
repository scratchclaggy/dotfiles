require("formatter").setup(
  {
    filetype = {
      c = {
        -- clang-format
        function()
          return {
            exe = "clang-format",
            args = {[[-style="{BasedOnStyle: llvm, IndentWidth: 4}"]]},
            stdin = true
          }
        end
      },
      cpp = {
        -- clang-format
        function()
          return {
            exe = "clang-format",
            args = {[[-style="{BasedOnStyle: llvm, IndentWidth: 4}"]]},
            stdin = true
          }
        end
      },
      arduino = {
        -- clang-format
        function()
          return {
            exe = "clang-format",
            args = {[[-style="{BasedOnStyle: llvm, IndentWidth: 4}"]]},
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
      },
      python = {
        -- black
        function()
          return {
            exe = "black",
            stdin = false,
          }
        end
      }
    }
  }
)
