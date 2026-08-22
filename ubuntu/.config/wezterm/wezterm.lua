local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- font config
config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMono Nerd Font Mono", weight = "Medium" },
})
config.font_size = 12
config.harfbuzz_features = { "calt=1", "liga=1", "clig=1" } -- enable ligatures
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"

-- color scheme
config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Gruvbox dark, medium (base16)"

-- config image
config.window_background_image = "/usr/share/backgrounds/osselo-Ask_a_friend.jpg"
-- config.window_background_image = os.getenv("HOME") .. "/bg/w-11.jpg"
config.window_background_image_hsb = {
	brightness = 0.1,
	-- hue = 0.6,
	-- saturation = 0.5,
}

-- window config
config.window_decorations = "TITLE | RESIZE"
-- config.window_background_opacity = 0.6
config.window_padding = {
	left = 0,
	right = 0,
	bottom = 0,
	top = 0,
}

-- tab bar config (Catppuccin Mocha powerline style)
local mocha = {
	crust = "#11111b",
	base = "#1e1e2e",
	surface0 = "#313244",
	surface1 = "#45475a",
	text = "#cdd6f4",
	lavender = "#b4befe",
	mauve = "#cba6f7",
	blue = "#89b4fa",
}

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.tab_max_width = 32
config.colors = {
	tab_bar = {
		background = mocha.crust,
		new_tab = { bg_color = mocha.crust, fg_color = mocha.text },
		new_tab_hover = { bg_color = mocha.surface1, fg_color = mocha.text },
	},
}

local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local process = tab.active_pane.foreground_process_name or ""
	local title = process:match("([^/]+)$") or tab.active_pane.title
	local is_active = tab.is_active

	local bg = is_active and mocha.mauve or (hover and mocha.surface1 or mocha.surface0)
	local fg = is_active and mocha.crust or mocha.text

	return {
		{ Background = { Color = mocha.crust } },
		{ Foreground = { Color = bg } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = " " .. wezterm.nerdfonts.md_folder_outline .. "  " .. title .. " " },
		{ Background = { Color = mocha.crust } },
		{ Foreground = { Color = bg } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

-- window-size config
config.initial_cols = 160 -- characters wide
config.initial_rows = 53 -- lines tall

-- Set window size to a % of the screen + center on startup
local STARTUP_SCALE = 0.8 -- 80% of screen size

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()

	local screen = wezterm.gui.screens().active
	local screen_width = screen.width
	local screen_height = screen.height

	local width = math.floor(screen_width * STARTUP_SCALE)
	local height = math.floor(screen_height * STARTUP_SCALE)

	wezterm.log_info(
		string.format(
			"[gui-startup] screen=%dx%d target=%dx%d",
			screen_width,
			screen_height,
			width,
			height
		)
	)

	-- Set size relative to screen (overrides initial_cols/initial_rows)
	gui_window:set_inner_size(width, height)

	wezterm.log_info(
		string.format(
			"[gui-startup] actual_after_set=%dx%d",
			gui_window:get_dimensions().pixel_width,
			gui_window:get_dimensions().pixel_height
		)
	)

	-- Calculate center position
	local x = (screen_width - width) / 2
	local y = (screen_height - height) / 2

	-- Set position
	gui_window:set_position(x, y)
end)

return config
