local wezterm = require("wezterm")

local config = wezterm.config_builder()
-- font config
config.font = wezterm.font("Hack Nerd Font", {
	weight = "Medium",
})
config.font_size = 14.6

-- color scheme
-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Gruvbox dark, medium (base16)"

-- config image
-- config.window_background_image = os.getenv("HOME") .. "/bg/arcane/w-0.jpg"
-- config.window_background_image = os.getenv("HOME") .. "/bg/w-11.jpg"
-- config.window_background_image_hsb = {
-- 	brightness = 0.3,
-- 	hue = 0.2,
-- 	saturation = 0.9,
-- }

-- window config
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
--config.macos_window_background_blur = 80
--config.window_background_opacity = 0.6
config.window_padding = {
	left = 0,
	right = 0,
	bottom = 0,
	top = 0,
}

-- window-size config
config.initial_cols = 160 -- characters wide
config.initial_rows = 53 -- lines tall

-- Center window on startup
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	local screen = wezterm.gui.screens().active
	local screen_width = screen.width
	local screen_height = screen.height

	-- Get window dimensions
	local window_width = gui_window:get_dimensions().pixel_width
	local window_height = gui_window:get_dimensions().pixel_height

	-- Calculate center position
	local x = (screen_width - window_width) / 2
	local y = (screen_height - window_height) / 2

	-- Set position
	gui_window:set_position(x, y)
end)

return config
