require("catppuccin").setup({
			flavour = "macchiato", -- latte, frappe, macchiato, mocha
			term_colors = false,
			transparent_background = false,
			no_italic = false,
			no_bold = false,
			styles = {
				comments = {},
				conditionals = {},
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
			},
			color_overrides = {
				macchiato = {
					base = "#101021",
					mantle = "#0A0A19",
					crust = "#0A0A19",
				},
			},
			highlight_overrides = {
				mocha = function(C)
					return {
						TabLineSel = { bg = C.pink },
						CmpBorder = { fg = C.surface2 },
						Pmenu = { bg = C.none },
						TelescopeBorder = { link = "FloatBorder" },
					}
				end,
			},
		})
vim.cmd('colorscheme catppuccin-macchiato')
