return {
  cmd = { "texlab" },
  filetypes = { "tex", "plaintex", "bib" },
  root_markers = { ".latexmkrc", ".texlabroot", "texlabroot", "Tectonic.toml", ".git" },
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        onSave = true,
      },
      chktex = { onOpenAndSave = true },
    },
  },
}

