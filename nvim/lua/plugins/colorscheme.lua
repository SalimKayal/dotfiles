return{
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("solarized").setup({
        transparent = { enabled = true },  -- replaces solarized_termtrans
      })
      vim.opt.background = "dark"
      vim.cmd.colorscheme("solarized")
      vim.opt.colorcolumn = "+1"
    end,
  },
}
