local status_ok, devicons = pcall(require, "nvim-web-devicons")

if not status_ok then
	return
end

local config = {
	override = {
		asm = { icon = " ", name = "Assembly" },
		haskell = { icon = " ", name = "haskell" },
		c = { icon = " ", name = "C" },
		css = { icon = " ", name = "CSS" },
		deb = { icon = "", name = "Deb" },
		Dockerfile = { icon = "", name = "Dockerfile" },
		md = { icon = "", name = "Markdown" },
		html = { icon = "", name = "HTML" },
		jpeg = { icon = "", name = "JPEG" },
		jpg = { icon = "", name = "JPG" },
		js = { icon = " ", name = "JS" },
		ts = { icon = " ", name = "TS" },
		zig = { icon = " ", name = "zig" },
		nim = { icon = " ", name = "nim" },
		nix = { icon = " ", name = "nix" },

		vue = { icon = "󰡄", name = "Vue" },
		kt = { icon = "", name = "Kt" },
		lock = { icon = "󰌾", name = "Lock" },
		mp3 = { icon = "󰎈", name = "MP3" },
		mp4 = { icon = "", name = "MP4" },
		out = { icon = "", name = "Out" },
		png = { icon = "", name = "PNG" },
		py = { icon = "", name = "Py" },
		rust = { icon = " ", name = "Rust" },
		go = { icon = " ", name = "Go" },
		toml = { icon = "", name = "TOML" },
		rb = { icon = "󰴭", name = "Ruby" },
		yuck = { icon = "󰇷", name = "Yuck" },
		vim = { icon = "", name = "Vim" },
		rpm = { icon = "", name = "RPM" },
		ttf = { icon = "", name = "TrueTypeFont" },
		woff = { icon = "", name = "WebOpenFontFormat" },
		woff2 = { icon = "", name = "WebOpenFontFormat2" },
		xz = { icon = "", name = "XZ" },
		zip = { icon = "", name = "Zip" },
	},
	default = true,
}

devicons.set_icon({
	sh = {
		icon = "",
		color = "#1DC123",
		cterm_color = "59",
		name = "Sh",
	},
	[".gitattributes"] = {
		icon = "",
		color = "#e24329",
		cterm_color = "59",
		name = "GitAttributes",
	},
	[".gitconfig"] = {
		icon = "",
		color = "#e24329",
		cterm_color = "59",
		name = "GitConfig",
	},
	[".gitignore"] = {
		icon = "",
		color = "#e24329",
		cterm_color = "59",
		name = "GitIgnore",
	},
	[".gitlab-ci.yml"] = {
		icon = " ",
		color = "#e24329",
		cterm_color = "166",
		name = "GitlabCI",
	},
	[".gitmodules"] = {
		icon = "",
		color = "#e24329",
		cterm_color = "59",
		name = "GitModules",
	},
	["diff"] = {
		icon = "",
		color = "#e24329",
		cterm_color = "59",
		name = "Diff",
	},
})

devicons.set_default_icon("󰈚")
devicons.setup(config)
