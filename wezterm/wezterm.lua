local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- Configuration table
local config = {}

-- Set color scheme
config.color_scheme = 'Black Metal (Dark Funeral) (base16)'

-- Set font and size
config.font = wezterm.font('CaskaydiaCove Nerd Font Mono')
config.font_size = 11

-- Set cursor style to a thicker blinking bar and make it blink faster
config.default_cursor_style = 'SteadyBlock'
config.cursor_blink_rate = 200 -- Blink rate in milliseconds (adjust as needed)

-- Set default program for PowerShell
config.default_prog = { 'pwsh.exe', '-nologo', '-WorkingDirectory', '~' }

-- Key bindings for copy and paste
config.keys = {
  { key = 'C', mods = 'CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
}

-- Mouse bindings
config.mouse_bindings = {
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
      end
    end),
  },
}

config.initial_cols = 1920
config.initial_rows = 540

-- Adjust text color brightness
config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.2,
  brightness = 1.5,
}

-- Set a solid background color without transparency
config.window_background_opacity = 0.6
config.win32_system_backdrop = "Acrylic"

-- Set launch menu (if needed)
config.launch_menu = {}

-- Return the configuration
return config
