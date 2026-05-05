return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()
		-- 必要な言語のパーサーを指定
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
			"rust",
		}
		pcall(function()
			require("nvim-treesitter").install(parsers)
		end)

		-- ハイライトの有効化
		-- mainブランチではファイルを開いた時に自分でnvim.treesitter.start()を呼ぶ必要がある
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("UserTreesitterHighlight", { clear = true }),
			callback = function(args)
				local ft = vim.bo[args.buf].filetype
				local lang = vim.treesitter.language.get_lang(ft) or ft

				-- パーサーが利用可能であれば、Neovimネイティブの強力なハイライトをONにする
				pcall(vim.treesitter.start, args.buf, lang)
			end,
		})
	end,
}
