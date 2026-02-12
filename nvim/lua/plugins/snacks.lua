return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fh", function() Snacks.picker.help() end, desc = "Help" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
      { "<leader>fc", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    },
    opts = {
      input = {},
      picker = {},
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      notifier = { enabled = true, style = "minimal" },
      terminal = { enabled = true },
    },
  },
}

