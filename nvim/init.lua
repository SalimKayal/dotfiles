-- ============================================
-- Basic Options
-- ============================================
vim.opt.backspace = "indent,eol,start"  -- bs=2
vim.opt.number = true
vim.opt.hidden = true
vim.opt.wrap = false
vim.opt.scrolloff = 5

-- Indentation
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Code width
vim.opt.textwidth = 100
vim.opt.linebreak = true

-- GUI options (only applies to GUI Neovim)
vim.opt.guioptions:remove("lrbLRTm")

-- Status line
vim.opt.statusline = "%<[%02n] %F%( %m%h%w%y%r%) %a%= %8l,%c%V/%L (%P) [%08O:%02B]"
vim.opt.laststatus = 2
vim.opt.showcmd = true

-- ============================================
-- Make Y behave like D and C
-- ============================================
vim.keymap.set('n', 'Y', 'y$', { noremap = true })

-- ============================================
-- Persistent Undo
-- ============================================
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"  -- Neovim-style path
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- ============================================
-- Toggle Relative Numbers
-- ============================================
vim.keymap.set('n', '<leader>n', function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { noremap = true })

-- ============================================
-- Temporary Buffer
-- ============================================
vim.keymap.set('n', '<leader>tb', ':enew<CR>:setlocal buftype=nofile bufhidden=hide noswapfile<CR>', { noremap = true })
vim.keymap.set('n', '<leader>vtb', ':vnew<CR>:setlocal buftype=nofile bufhidden=hide noswapfile<CR>', { noremap = true })

-- ============================================
-- Search Options
-- ============================================
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.keymap.set('n', '<leader>h', ':set hlsearch!<CR>', { noremap = true })
vim.keymap.set('n', '/', ':set hlsearch<CR>/', { noremap = true })

-- ============================================
-- Window Navigation Mappings
-- ============================================
vim.keymap.set('n', '<Left>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<Right>', '<C-w>l', { noremap = true })
vim.keymap.set('n', '<Up>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<Down>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<S-Left>', '<C-w>H', { noremap = true })
vim.keymap.set('n', '<S-Right>', '<C-w>L', { noremap = true })
vim.keymap.set('n', '<S-Up>', '<C-w>K', { noremap = true })
vim.keymap.set('n', '<S-Down>', '<C-w>J', { noremap = true })

-- ============================================
-- Dvorak Navigation Remapping
-- ============================================
local dvorak_maps = {
  { 'q', 'h' }, { 'Q', 'H' },
  { 'h', 'x' }, { 'H', 'X' },
  { 'x', 'l' }, { 'X', 'L' },
  { 'l', 'q' }, { 'L', 'Q' },
}

for _, map in ipairs(dvorak_maps) do
  vim.keymap.set({ 'n', 'v' }, map[1], map[2], { noremap = true })
end

-- ============================================
-- Custom Mappings
-- ============================================
vim.keymap.set({ 'n', 'v' }, ';', ':', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<space>', ';', { noremap = true })

-- Shortcut for init.lua
vim.keymap.set('n', 'vrc', ':tabnew $MYVIMRC<CR>', { noremap = true })

-- ============================================
-- Auto-reload Config on Save
-- ============================================
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = vim.fn.stdpath("config") .. "/init.lua",
  callback = function()
    dofile(vim.env.MYVIMRC)
  end,
})

-- ============================================
-- Filetype: Gnuplot
-- ============================================
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.plt", ".gnuplot" },
  callback = function()
    vim.bo.filetype = "gnuplot"
  end,
})

-- ============================================
-- Filetype: C, C++, Java, ObjC
-- ============================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "cs", "java", "objc" },
  callback = function()
    vim.opt_local.cindent = true
    vim.opt_local.cscopetag = true
    vim.opt_local.cscopetagorder = 0
    vim.opt_local.cinkeys = "0{,0},:,0#,!^F"
    vim.opt_local.foldmethod = "syntax"
  end,
})

-- ============================================
-- Filetype: Python
-- ============================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.keymap.set('n', '<F5>', ':!python %<CR>', { buffer = true })
  end,
})

-- ============================================
-- Filetype: Lua
-- ============================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.tags = "lua.tags"
  end,
})

-- ============================================
-- Filetype: LaTeX
-- ============================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

---- ============================================
---- Completion Behavior
---- ============================================
--vim.api.nvim_create_autocmd({ "CursorMovedI", "InsertLeave" }, {
--  callback = function()
--    if vim.fn.pumvisible() == 0 then
--      pcall(vim.cmd, "pclose")
--    end
--  end,
--})
--
--vim.opt.completeopt = { "menuone", "menu", "longest", "preview" }
--
--vim.keymap.set('i', '<Tab>', function()
--  return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
--end, { expr = true, noremap = true })
--
--vim.keymap.set('i', '<S-Tab>', function()
--  return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
--end, { expr = true, noremap = true })
--
--vim.keymap.set('i', '<CR>', function()
--  return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
--end, { expr = true, noremap = true })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require("lazy").setup({
  spec = { { import = "plugins" } },
  rocks = { enabled = false },
})

