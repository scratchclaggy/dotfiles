local cmd = require("utilities").cmd

return {
  {
    "TimUntersberger/neogit",
    keys = {
      {
        "<leader>gg",
        cmd("Neogit"),
      },
    },
  },
}
