local nest = require("nest")

nest.applyKeymaps {
  {
    "<leader>",
    {
      {"e", "<cmd>Trouble<cr>"},
      {
        "f",
        {
          {"f", "<cmd>Telescope find_files<cr>"},
          {"h", "<cmd>Telescope help_tags<cr>"},
          {"j", "<cmd>Telescope buffers<cr>"},
          {"m", "<cmd>Format<cr>"}
        }
      },
      {"g", "<cmd>tab G<cr>"},
      {
        "s",
        {
          {"a", "gg0vG$"},
          {"h", "<cmd>FocusSplitLeft<cr>"},
          {"j", "<cmd>FocusSplitDown<cr>"},
          {"k", "<cmd>FocusSplitUp<cr>"},
          {"l", "<cmd>FocusSplitRight<cr>"}
        }
      },
      {"rn", "<cmd>lua vim.lsp.buf.rename()<cr>"},
      {"qn", "<cmd>wqa<cr>"},
      {
        "v",
        {
          {"s", "<cmd>vs<cr>"}
        }
      },
      {"w", "<cmd>w<cr>"},
      {"x", "<c-w>q"}
    }
  },
  {
    "gd",
    "<cmd>lua vim.lsp.buf.definition()<CR>"
  },
  {
    "gD",
    "<cmd>lua vim.lsp.buf.declaration()<CR>"
  },
  {
    "gi",
    "<cmd>lua vim.lsp.buf.implementation()<CR>"
  },
  {"K", "<cmd>lua vim.lsp.buf.hover()<cr>"},
  {"Q", "<nop>"},
  {"<tab>", "<cmd>b#<cr>"},
  {"<s-tab>", "<cmd>bprevious<cr>"},
  {"<", "<gv", mode = "v"},
  {">", ">gv", mode = "v"},
  {
    "<c-",
    {
      {"h>", "<c-w>h"},
      {"j>", "<c-w>j"},
      {"k>", "<c-w>k"},
      {"l>", "<c-w>l"}
    }
  }
}
