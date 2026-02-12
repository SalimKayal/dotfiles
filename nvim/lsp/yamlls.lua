return {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
    root_markers = { ".git" },
    settings = {
        yaml = {
            schemas = {
                schemaStore = { enable = false, url = "" },
                schemas = require("schemastore").yaml.schemas(),
            },
            validate = true,
        },
    },
}
