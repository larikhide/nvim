return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-frecency.nvim",
    },

	opts = {},

	config = function()

        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        --vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)

        require("telescope").load_extension "frecency"
        -- open frecency picker
        vim.keymap.set("n", "<leader>ff", function()
            require("telescope").extensions.frecency.frecency {
                workspace = "CWD",
            }
        end)
    end
}
