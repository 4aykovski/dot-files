local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

lspconfig.jsonls.setup {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = true,
  },
  root_dir = util.find_git_ancestor,
  single_file_support = true,
}

lspconfig.cssls.setup {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
  root_dir = util.root_pattern("package.json", ".git"),
  single_file_support = true,
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}

lspconfig.html.setup {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "templ" },
  root_dir = util.root_pattern("package.json", ".git"),
  single_file_support = true,
  settings = {},
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup {
  init_options = { hostInfo = "neovim" },
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
  root_dir = util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
  single_file_support = true,
}

local function python_organize_imports()
  local params = {
    command = "pyright.organizeimports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }

  local clients = util.get_lsp_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  }

  for _, client in ipairs(clients) do
    client.request("workspace/executeCommand", params, nil, 0)
  end
end

local function set_python_path(path)
  local clients = util.get_lsp_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  }
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
    end
    client.notify("workspace/didChangeConfiguration", { settings = nil })
  end
end

lspconfig.pyright.setup {
  default_config = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = util.root_pattern("pyproject.toml, setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git"),
    single_file_support = true,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
  },
  commands = {
    PyrightOrganizeImports = {
      python_organize_imports,
      description = "Organize Imports",
    },
    PyrightSetPythonPath = {
      set_python_path,
      description = "Reconfigure pyright with the provided python path",
      nargs = 1,
      complete = "file",
    },
  },
  docs = {
    description = [[
https://github.com/microsoft/pyright

`pyright`, a static type checker and language server for python
]],
  },
}

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = false
    on_attach(client, bufnr)
  end,
  default_config = {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_dir = util.root_pattern(
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compfile_flags.txt",
      "configure.ac"
    ),
    single_file_support = true,
    capabilities = {
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = true,
          },
        },
      },
      offsetEncoding = { "utf-8", "utf-16" },
    },
  },
}
