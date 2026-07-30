return {
  -- ══════════════════════════════════════════════════════════
  -- Schema catalogue for jsonls / yamlls
  -- ══════════════════════════════════════════════════════════
  { "b0o/schemastore.nvim", lazy = true },

  -- ══════════════════════════════════════════════════════════
  -- Mason: package manager for LSP servers/tools
  -- ══════════════════════════════════════════════════════════
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },

  -- ══════════════════════════════════════════════════════════
  -- Automatic installation / upgrade of Mason packages.
  -- Replaces mason-lspconfig: we no longer need nvim-lspconfig
  -- at all because every server is configured natively under
  -- nvim/lsp/*.lua and enabled via vim.lsp.enable().
  -- ══════════════════════════════════════════════════════════
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim",
      "folke/snacks.nvim",
    },
    opts = {
      ensure_installed = {
        "basedpyright",
        "ruff",
        "bash-language-server",
        "gopls",
        "clangd",
        "lua-language-server",
        "texlab",
        "marksman",
        "yaml-language-server",
        "taplo",
        "json-lsp",
      },
      -- Do not pull in the legacy lspconfig bridge just for name
      -- translation.  The names above are Mason package names.
      integrations = {
        ["mason-lspconfig"] = false,
        ["mason-null-ls"] = false,
        ["mason-nvim-dap"] = false,
      },
    },
    config = function(_, opts)
      require("mason-tool-installer").setup(opts)

      -- ────────────────────────────────────────────────────
      -- Server Setup (Neovim 0.11+)
      -- ────────────────────────────────────────────────────
      vim.lsp.config("*", {
        root_markers = { ".git" },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      vim.lsp.enable({
        "basedpyright", "ruff", "bashls",
        "gopls", "clangd", "lua_ls",
        "texlab", "marksman",
        "yamlls", "taplo", "jsonls",
      })

      -- ────────────────────────────────────────────────────
      -- Diagnostic Display
      -- ────────────────────────────────────────────────────
      vim.diagnostic.config({
        virtual_text = { spacing = 4, prefix = "●" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- ────────────────────────────────────────────────────
      -- Keymaps
      -- ────────────────────────────────────────────────────
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          -- Picker-based (multi-result navigation)
          local pick = Snacks.picker
          map("n", "gd",         pick.lsp_definitions,       "Definition")
          map("n", "gD",         pick.lsp_declarations,      "Declaration")
          map("n", "gr",         pick.lsp_references,        "References")
          map("n", "gi",         pick.lsp_implementations,   "Implementation")
          map("n", "gy",         pick.lsp_type_definitions,  "Type definition")
          map("n", "<leader>ds", pick.lsp_symbols,           "Document symbols")
          map("n", "<leader>ws", pick.lsp_workspace_symbols, "Workspace symbols")
          map("n", "<leader>dd", pick.diagnostics_buffer,    "Buffer diagnostics")
          map("n", "<leader>dw", pick.diagnostics,           "Workspace diagnostics")

          -- Native (single-action)
          local lsp = vim.lsp.buf
          local diag = vim.diagnostic
          map("n", "K",          lsp.hover,                                          "Hover")
          map("n", "<C-k>",      lsp.signature_help,                                 "Signature help")
          map("i", "<C-k>",      lsp.signature_help,                                 "Signature help")
          map("n", "<leader>ca", lsp.code_action,                                    "Code action")
          map("n", "<leader>rn", lsp.rename,                                         "Rename")
          map("n", "<leader>f",  function() lsp.format({ async = true }) end,        "Format")
          map("n", "[d",         function() diag.jump({ count = -1, float = true }) end, "Prev diagnostic")
          map("n", "]d",         function() diag.jump({ count = 1, float = true }) end,  "Next diagnostic")
          map("n", "<leader>e",  diag.open_float,                                    "Diagnostic float")
        end,
      })
    end,
  },
}
