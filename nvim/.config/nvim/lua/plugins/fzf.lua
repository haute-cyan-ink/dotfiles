return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		-- 隠しファイルを含めてファイル検索
		{ "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Telescope find_files (hidden)" },
		-- 隠しファイルを含めて全文検索
		{
			"<leader>fg",
			'<cmd>Telescope live_grep additional_args={"--hidden"}<cr>',
			desc = "Telescope live_grep (hidden)",
		},
		-- .gitignoreを無視してすべてのファイルを検索 (Find All)
		{
			"<leader>fa",
			"<cmd>Telescope find_files hidden=true no_ignore=true<cr>",
			desc = "Telescope find_files (all)",
		},
		-- ヘルプタグ
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help_tags" },
	},
}
