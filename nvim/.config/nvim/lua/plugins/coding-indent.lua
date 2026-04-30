return {
	"lukas-reineke/indent-blankline.nvim",
	dependencies = {
		"HiPhish/rainbow-delimiters.nvim",
		{ "nvim-treesitter/nvim-treesitter", branch = "main" },
	},
	config = function()
		local ts = require("nvim-treesitter")

		-- 1. パーサーのインストール
		-- Neovim自体の設定や基礎的な言語を追加
		local parsers = {
			"lua",
			"vim",
			"vimdoc",
			"query",
			"python",
			"typescript",
			"javascript",
			"markdown",
			"markdown_inline",
		}
		for _, p in ipairs(parsers) do
			-- すでにインストールされている場合はスキップ、なければインストール
			pcall(ts.install, p)
		end

		-- 2. ハイライトの有効化
		vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
			callback = function(args)
				local ft = vim.bo[args.buf].filetype
				if ft == "" then
					return
				end
				local lang = vim.treesitter.language.get_lang(ft) or ft
				-- パーサーが利用可能か確認して開始
				if pcall(require("nvim-treesitter.parsers").get_parser, args.buf, lang) then
					vim.treesitter.start(args.buf, lang)
				end
			end,
		})

		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
		end)
		vim.g.rainbow_delimiters = { highlight = highlight }
		require("ibl").setup({ scope = { highlight = highlight } })

		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
}
