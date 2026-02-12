return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  init_options = {
    settings = {
      lineLength = 100,
      lint = {
        select = { "E", "F", "W", "I", "UP", "B", "C4", "SIM" },
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Disable hover in favor of basedpyright
    client.server_capabilities.hoverProvider = false
  end,
}

