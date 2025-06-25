return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},
	{
		"neanias/everforest-nvim",
		version = false,
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				-- Your config here
				show_eob = false,
			})
		end,
	},
}
