return {
  {
    "nickjvandyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {}, } },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        provider = {
          enabled = "terminal",
          terminal = {
            -- Default settings work well, customize if needed
            direction = "right",  -- or "bottom"
            size = 30,            -- percentage
          },
        },
      }

      -- Required for automatic file reloading
      vim.o.autoread = true

      local oc = require("opencode")

      -- ═══════════════════════════════════════════════════
      -- Leader-based keymaps (your preference)
      -- ═══════════════════════════════════════════════════

      -- Toggle opencode
      vim.keymap.set({ "n", "t" }, "<leader>oo", oc.toggle, { desc = "Toggle opencode" })
      -- Ask with context
      vim.keymap.set({ "n", "x" }, "<leader>oa", function()
        oc.ask("@this: ", { submit = true })
      end, { desc = "Ask opencode" })
      -- Select action (review, explain, fix, etc.)
      vim.keymap.set({ "n", "x" }, "<leader>os", oc.select, { desc = "Select opencode action" })
      -- Operator: add range to opencode context
      vim.keymap.set({ "n", "x" }, "<leader>or", function()
        return oc.operator("@this ")
      end, { expr = true, desc = "Add range to opencode" })
      -- Add current line
      vim.keymap.set("n", "<leader>ol", function()
        return oc.operator("@this ") .. "_"
      end, { expr = true, desc = "Add line to opencode" })
    end,
  },
}

