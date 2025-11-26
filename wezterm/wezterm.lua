local wezterm = require 'wezterm'

local function is_macos()
  return wezterm.target_triple:find 'darwin' ~= nil
end

local direction_keys = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

return {
  color_scheme = 'Catppuccin Mocha',
  font_size = is_macos() and 16 or 14,
  font = wezterm.font_with_fallback {
    'Monaspace Neon Frozen',
    { family = 'Symbols Nerd Font Mono', scale = 0.75 },
  },
  line_height = 1.2,

  -- timeout_milliseconds defaults to 1000 and can be omitted
  leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = {
    {
      -- Split Vertical
      key = '-',
      mods = 'LEADER',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      -- Split Horizontal
      key = '|',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'h',
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
      key = 'j',
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
      key = 'k',
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
      key = 'l',
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection 'Right',
    },
  },
  window_decorations = 'RESIZE',
  window_padding = {
    top = 0,
    bottom = 0,
  },
}
