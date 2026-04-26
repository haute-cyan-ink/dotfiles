-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
config.automatically_reload_config = true

-- WezTermで画像を表示するための下準備
config.enable_kitty_graphics = true

-- 日本語をいい感じにするフォント
config.font = wezterm.font("Firge35Nerd Console")

-- フォントサイズ
config.font_size = 12.0

-- IMEで日本語入力をする設定
config.use_ime = true

-- 背景の透過
config.window_background_opacity = 0.85

-- ぼかし
config.macos_window_background_blur = 20

-- タブ関連の設定
config.window_decorations = "RESIZE"

-- タブが1つの時にタブバーを隠す
config.hide_tab_bar_if_only_one_tab = false

-- ウィンドウのフレームを削除
config.window_frame = {
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
}

-- グラデーションのほうがかっこいい
config.window_background_gradient = {
	orientation = "Vertical",
	colors = {
		"#0f0c29",
		"#302b63",
		"#24243e",
	},
	interpolation = "Linear",
	blend = "Rgb",
}

-- タブのいらないボタンを削除
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

-- タブの境界線を削除
config.colors = {
	tab_bar = {
		inactive_tab_edge = "none",
	},
}

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

-- ウィンドウ枠右上に時刻を表示
wezterm.on("update-right-status", function(window, pane)
	local date_end_time = wezterm.strftime("%Y-%m-%d %H:%M:%S")
	window:set_right_status(wezterm.format({
		{ Attribute = { Underline = "Single" } },
		{ Attribute = { Italic = true } },
		{ Text = wezterm.nerdfonts.mdi_clock .. " " .. date_end_time },
	}))
end)
-- アクティブタブと非アクティブタブの色をわかりやすく
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"
	local edge_background = "none"

	if tab.is_active then
		background = "#ae8b2d"
		foreground = "#FFFFFF"
	end
	local edge_foreground = background

	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

-- キーバインド
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.disable_default_key_bindings = true
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'

-- and finally, return the configuration to wezterm
return config
