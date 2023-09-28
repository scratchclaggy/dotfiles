return {
  "2nthony/sortjson.nvim",
  cmd = {
    "SortJSONByAlphaNum",
    "SortJSONByAlphaNumReverse",
    "SortJSONByKeyLength",
    "SortJSONByKeyLengthReverse",
  },
  keys = { { "<leader>cj", "<cmd>SortJSONByAlphaNum<cr>", desc = "JSON Sort" } },
  config = true,
}
