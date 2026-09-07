local wezterm = require("wezterm")

local config = wezterm.config_builder()
-- font config
config.font = wezterm.font("JetBrainsMono Nerd Font", {
	weight = "Medium",
})
config.font_size = 13

-- color scheme
config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Gruvbox dark, medium (base16)"

-- Catppuccin Mocha palette (used by the tab bar below)
local palette = {
	base = "#1e1e2e",
	mantle = "#181825",
	crust = "#11111b",
	text = "#cdd6f4",
	subtext = "#a6adc8",
	surface0 = "#313244",
	surface1 = "#45475a",
	overlay0 = "#6c7086",
	blue = "#89b4fa",
	lavender = "#b4befe",
	mauve = "#cba6f7",
	red = "#f38ba8",
	green = "#a6e3a1",
}

-- config image
-- config.window_background_image = os.getenv("HOME") .. "/bg/arcane/w-0.jpg"
-- config.window_background_image = os.getenv("HOME") .. "/bg/w-11.jpg"
-- config.window_background_image_hsb = {
-- 	brightness = 0.3,
-- 	hue = 0.2,
-- 	saturation = 0.9,
-- }

-- window config
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.integrated_title_button_style = "MacOsNative"
config.integrated_title_button_alignment = "Left"
config.macos_window_background_blur = 70
config.window_background_opacity = 0.8
config.window_padding = {
	left = 0,
	right = 0,
	bottom = 0,
	top = 0,
}

-- tab bar config
-- fancy bar has its own sizing (window_frame.font_size) independent of the
-- terminal font, so the integrated traffic-light buttons aren't cramped
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 32
config.show_new_tab_button_in_tab_bar = true
config.show_tab_index_in_tab_bar = true
config.tab_and_split_indices_are_zero_based = false

config.window_frame = {
	font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" }),
	font_size = 13,
	active_titlebar_bg = palette.crust,
	inactive_titlebar_bg = palette.crust,
}

config.colors = {
	tab_bar = {
		background = palette.crust,
		active_tab = {
			bg_color = palette.mauve,
			fg_color = palette.crust,
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = palette.surface0,
			fg_color = palette.subtext,
		},
		inactive_tab_hover = {
			bg_color = palette.surface1,
			fg_color = palette.text,
		},
		new_tab = {
			bg_color = palette.crust,
			fg_color = palette.subtext,
		},
		new_tab_hover = {
			bg_color = palette.surface1,
			fg_color = palette.text,
			italic = false,
		},
	},
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local index = tab.tab_index + 1
	local title = tab.active_pane.title
	if tab.active_pane.foreground_process_name and tab.active_pane.foreground_process_name ~= "" then
		title = tab.active_pane.foreground_process_name:match("([^/\\]+)$") or title
	end
	local max_title_width = max_width - 4
	if #title > max_title_width then
		title = title:sub(1, max_title_width - 1) .. "…"
	end

	return string.format(" %d  %s ", index, title)
end)

wezterm.on("update-status", function(window, pane)
	local date = wezterm.strftime("%H:%M")
	window:set_right_status(wezterm.format({
		{ Background = { Color = palette.crust } },
		{ Foreground = { Color = palette.blue } },
		{ Text = "  " .. date .. " " },
	}))
end)

-- window-size config
config.initial_cols = 200 -- characters wide
config.initial_rows = 100 -- lines tall

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
