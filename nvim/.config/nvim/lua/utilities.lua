return {
  cmd = function(cmd_string)
    print(cmd_string)
    return "<cmd>" .. cmd_string .. "<cr>"
  end,

  plug = function(cmd_string)
    return "<plug>(" .. cmd_string .. ")"
  end,
}
