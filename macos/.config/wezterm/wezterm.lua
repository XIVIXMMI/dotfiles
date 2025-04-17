local wezterm = require("wezterm")

local config = wezterm.config_builder()
-- font config
config.font = wezterm.font("Hack Nerd Font", {
	weight = "Medium",
})
config.font_size = 15

-- color scheme
config.color_scheme = "Cyberdream"

--config.color_scheme = ""

-- config image
-- config.window_background_image = os.getenv("HOME") .. "/bg/arcane/w-0.jpg"
-- config.window_background_image = os.getenv("HOME") .. "/bg/w-11.jpg"
config.window_background_image_hsb = {
	brightness = 0.3,
	-- hue = 0.2,
	-- saturation = 0.9,
}

-- window config
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.macos_window_background_blur = 40
config.window_background_opacity = 0.5
config.window_padding = {
	left = 0,
	right = 0,
	bottom = 0,
	top = 0,
}

-- window-size config
config.initial_cols = 999
config.initial_rows = 999

return config
