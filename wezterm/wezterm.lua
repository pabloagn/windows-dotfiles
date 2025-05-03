-- ~/.config/wezterm/wezterm.lua or ~/.wezterm.lua

-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- This table will hold the configuration.
local config = wezterm.config_builder()

-- Basic Setup & Behavior
-- =======================
config.automatically_reload_config = true -- Reload config automatically when file changes
config.default_prog = { 'pwsh.exe', '-nologo', '-WorkingDirectory', '~' } -- Your preferred shell
config.scrollback_lines = 5000             -- Increase scrollback buffer size
config.hide_mouse_cursor_when_typing = true -- Less distraction
config.audible_bell = "Disabled"           -- Disable audible bell
config.check_for_updates = true            -- Check for updates periodically
config.show_update_window = true           -- Show a GUI window when an update is found

-- Appearance
-- ==========
config.color_scheme = 'Black Metal (Dark Funeral) (base16)'

-- Font Configuration (Using font_with_fallback for better glyph coverage)
config.font = wezterm.font_with_fallback({
  'FiraCode Nerd Font',
  -- Add fallback fonts if needed, e.g., for specific symbols or languages
  'Symbols Nerd Font Mono',
  'Noto Color Emoji',
})
config.font_size = 11.0

-- Enable Font Ligatures (Common for Fira Code)
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

-- Cursor Style
config.default_cursor_style = 'SteadyBar' -- Your preferred steady bar
config.cursor_blink_rate = 0            -- Disable blinking as requested
-- config.cursor_thickness = '2px'      -- Uncomment and adjust if you want a thicker bar

-- Text Appearance Adjustment
config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.2, -- Slightly more saturated text
  brightness = 1.5, -- Brighter text
}

-- Window Appearance & Transparency (Platform Specific)
-- config.window_background_opacity = 0.85 -- Slightly less transparent than before for readability
-- config.text_background_opacity = 0.85   -- Match text background opacity if needed

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  -- Windows Specific Acrylic Background
  config.win32_system_backdrop = "Acrylic"
  config.window_background_opacity = 0.6 -- Your desired opacity for Acrylic
  -- config.win32_acrylic_accent_color = "#111111" -- Optional: tint the acrylic
elseif wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple == "aarch64-apple-darwin" then
  -- macOS Specific Background Blur
  config.macos_window_background_blur = 30 -- Adjust blur radius (0-100)
  config.window_background_opacity = 0.7   -- Adjust opacity for macOS blur
else
  -- General Linux/Other Transparency (Requires compositor support)
  config.window_background_opacity = 0.8 -- Adjust opacity for non-Windows/macOS
end

-- Window Frame and Padding
config.window_decorations = "RESIZE" -- Use client-side decorations (nicer integration sometimes)
-- config.window_decorations = "DEFAULT" -- Uncomment if you prefer native title bar/buttons
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

-- Tab Bar Configuration
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true -- Cleaner look with a single tab
config.use_fancy_tab_bar = true            -- Nicer looking tabs
config.tab_bar_at_bottom = false           -- Tabs at the top (default)
config.show_new_tab_button_in_tab_bar = true
config.tab_max_width = 32 -- Max width for tab titles

-- Key Bindings
-- ============
config.keys = {
  -- Your Custom Copy/Paste (Overrides default terminal CTRL+C for interrupt)
  -- Be aware: CTRL+C will *not* send an interrupt signal to the running process.
  { key = 'C', mods = 'CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },

  -- Standard Copy/Paste (Recommended for terminal usage)
  -- Uncomment these and comment out the above if you prefer CTRL+SHIFT+C/V
  -- { key = 'C', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  -- { key = 'V', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
  -- { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'PrimarySelection' }, -- Linux style middle-click paste

  -- Font Size Adjustments
  { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },

  -- Tab Management
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CTRL', action = act.CloseCurrentTab { confirm = true } },
  { key = ']', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = '[', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
  -- { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) }, -- Alternative Tab Nav
  -- { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) }, -- Alternative Tab Nav
  { key = 'n', mods = 'CTRL|SHIFT', action = act.ShowTabNavigator },
  { key = '1', mods = 'ALT', action = act.ActivateTab(0) }, -- ALT+1 for first tab, etc.
  { key = '2', mods = 'ALT', action = act.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = act.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = act.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = act.ActivateTab(4) },
  { key = '6', mods = 'ALT', action = act.ActivateTab(5) },
  { key = '7', mods = 'ALT', action = act.ActivateTab(6) },
  { key = '8', mods = 'ALT', action = act.ActivateTab(7) },
  { key = '9', mods = 'ALT', action = act.ActivateTab(-1) }, -- ALT+9 for last tab

  -- Pane Management
  { key = '%', mods = 'ALT|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },   -- ALT+SHIFT+% (usually Shift+5)
  { key = '"', mods = 'ALT|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } }, -- ALT+SHIFT+" (usually Shift+')
  { key = 'z', mods = 'CTRL|SHIFT', action = act.TogglePaneZoomState },
  { key = 'x', mods = 'CTRL|SHIFT', action = act.CloseCurrentPane { confirm = true } },
  { key = 'LeftArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
  -- { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' }, -- Vim style pane nav
  -- { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  -- { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  -- { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },

  -- Scrolling
  { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },

  -- Quick Select / Search
  { key = ' ', mods = 'CTRL|SHIFT', action = act.QuickSelect },

  -- Reload Configuration
  { key = 'R', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },

  -- Debug Overlay
  -- { key = 'L', mods = 'CTRL|SHIFT', action = act.ShowDebugOverlay },
}

-- Mouse Bindings
-- ==============
config.mouse_bindings = {
  -- Your triple-click selection
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },

  -- Your Right-click Copy/Paste behavior
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        -- Copy selection to clipboard and primary selection (if available)
        window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
        -- Clear the selection after copying
        window:perform_action(act.ClearSelection, pane)
      else
        -- If no selection, paste from clipboard
        window:perform_action(act.PasteFrom "Clipboard", pane)
      end
    end),
  },

  -- Standard middle-click paste from Primary Selection (Linux-like)
  {
    event = { Down = { streak = 1, button = 'Middle' } },
    mods = 'NONE',
    action = act.PasteFrom 'PrimarySelection',
  },

  -- Ctrl+Scroll wheel to adjust font size
  {
    event = { Up = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'CTRL',
    action = act.IncreaseFontSize,
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'CTRL',
    action = act.DecreaseFontSize,
  },
}

-- Hyperlink Rules (Using defaults is often fine, explicitly set for clarity)
-- You can customize these to detect different URL patterns
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Initial Window State (Maximize on Startup)
-- ==========================================
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- Optional: Define Launch Menu Items (Press Win+Alt+L or Super+Alt+L by default)
-- ===============================================================================
config.launch_menu = {
  { label = 'PowerShell', args = { 'pwsh.exe', '-nologo' } },
  { label = 'Command Prompt', args = { 'cmd.exe' } },
  -- Add more entries as needed, e.g., for WSL or specific project directories
  -- { label = "WSL Ubuntu", args = { "wsl.exe", "-d", "Ubuntu", "~" } },
}


-- Final Step: Return the configuration
-- ====================================
return config