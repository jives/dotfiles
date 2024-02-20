return {
    "nvim-telescope/telescope.nvim", tag = "0.1.5",
    event = 'VimEnter',
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    keys = {
        {"<leader>/", function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "[/] Fuzzily find in current buffer"},
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
