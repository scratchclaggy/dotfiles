local nest = require("nest")

nest.applyKeymaps {
  {
    "<leader>",
    {
      {"ca", "<cmd>Lspsaga code_action<cr>"},
      {"ca", "<cmd>Lspsaga range_code_action<cr>", mode = "v"},
      {"d", ":Bdelete<cr>"},
      {
        "e",
        {
          {"n", "<cmd>Lspsaga diagnostic_jump_next<CR>"},
          {"p", "<cmd>Lspsaga diagnostic_jump_prev<CR>"},
          {"r", "<cmd>Lspsaga show_line_diagnostics<cr>"}
        }
      },
      {
        "f",
        {
          {"f", "<cmd>Telescope find_files<cr>"},
          {"h", "<cmd>Telescope help_tags<cr>"},
          {"j", "<cmd>Telescope buffers<cr>"},
          {"m", "<cmd>Format<cr>"}
        }
      },
      {"g", ":tab G<cr>"},
      {
        "sa",
        "gg0vG$"
      },
      {"rn", "<cmd>Lspsaga rename<cr>"},
      {"qn", "<cmd>wqa<cr>"},
      {
        "v",
        {
          {"s", "<cmd>vs<cr>"}
        }
      },
      {"w", "<cmd>w<cr>"}
    }
  },
  {
    "gd",
    "<cmd>Lspsaga preview_definition<CR>"
  },
  {
    "gh",
    "<cmd>Lspsaga lsp_finder<CR>"
  },
  {
    "gs",
    "<cmd>Lspsaga signature_help<CR>"
  },
  {"K", "<cmd>Lspsaga hover_doc<cr>"},
  {"Q", "<nop>"},
  {"<tab>", ":b#<cr>"},
  {"<s-tab>", ":bprevious<cr>"},
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
