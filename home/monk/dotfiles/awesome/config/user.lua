local M = {}

M.config = {
	-- My profile config
	user = "vaibhav garg",
	home = os.getenv("HOME"),
	host = "aorus",
	theme = "catppuccin_mocha",
	font = "FiraCode Nerd Font Bold 10",
}

M.apps = {
	-- My profile apps
	terminal = "alacritty",
	web_browser = "qutebrowser",
	text_editor = "nvim",
	launcher = "rofi -show drun",
	file_manager = "alacritty -e yazi",
	screnshoot = "flameshot",
	image_viewer = "sxiv",
}

return M
