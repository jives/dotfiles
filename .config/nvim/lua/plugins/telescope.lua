local cmake = vim.env.VIM_CMAKE or "cmake"

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	event = "VimEnter",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
            -- stylua: ignore
            build = cmake .. " -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && " .. cmake .. " --build build --config Release && " .. cmake .. " --install build --prefix build",
			enabled = vim.fn.executable(cmake) == 1,
		},
	},
	config = function()
		require("telescope").load_extension("fzf")
	end,
    -- stylua: ignore
    keys = {
        {"<leader>/", function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Fuzzily find in current buffer"},
        {"<leader>ff", function() require("telescope.builtin").find_files() end, desc = "[F]ind [F]ile"},
        {"<leader>fg", function() require("telescope.builtin").git_files() end, desc = "[F]ind [G]it file"},
        {"<leader>fo", function() require("telescope.builtin").oldfiles() end, desc = "[F]ind recently [O]pened file"},
        {"<leader>fb", function() require("telescope.builtin").buffers() end, desc = "[F]ind existing [B]uffers"},
        {"<leader>fs", function() require("telescope.builtin").builtin() end, desc = "[F]ind [S]elect Telescope"},
        {"<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "[F]ind [H]elp"},
        {"<leader>fw", function() require("telescope.builtin").grep_string() end, desc = "[F]ind current [W]ord"},
        {"<leader>fG", function() require("telescope.builtin").live_grep() end, desc = "[F]ind by [G]rep"},
        {"<leader>fd", function() require("telescope.builtin").diagnostics() end, desc = "[F]ind in [D]iagnostics"},
        {"<leader>fr", function() require("telescope.builtin").resume() end, desc = "[F]ind [R]resume"},
    },
}
