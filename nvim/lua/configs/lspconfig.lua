local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.gopls.setup({
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	capabilities = capabilities,
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
			hints = {
				rangeVariableTypes = true,
				parameterNames = true,
				constantValues = true,
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				functionTypeParameters = true,
			},
		},
	},
})

lspconfig.jsonls.setup({
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	init_options = {
		provideFormatter = true,
	},
	root_dir = util.find_git_ancestor,
	single_file_support = true,
	capabilities = capabilities,
})

lspconfig.cssls.setup({
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
	root_dir = util.root_pattern("package.json", ".git"),
	capabilities = capabilities,
	single_file_support = true,
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
})

lspconfig.html.setup({
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html", "templ" },
	root_dir = util.root_pattern("package.json", ".git"),
	ingle_file_support = true,
	capabilities = capabilities,
	settings = {},
	init_options = {
		provideFormatter = true,
		embeddedLanguages = { css = true, javascript = true },
		configurationSection = { "html", "css", "javascript" },
	},
})

local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}
	vim.lsp.buf.execute_command(params)
end

lspconfig.ts_ls.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vim.fn.stdpath("data")
					.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
				languages = { "vue" },
			},
		},
	},
	ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	settings = {
		typescript = {
			tsserver = {
				useSyntaxServer = false,
			},
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		jsx_close_tag = {
			enable = true,
			filetypes = { "javascriptreact", "typescriptreact" },
		},
	},
	capabilities = capabilities,
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
	root_dir = util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
	single_file_support = true,
})

local function python_organize_imports()
	local params = {
		command = "pyright.organizeimports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}

	local clients = util.get_lsp_clients({
		bufnr = vim.api.nvim_get_current_buf(),
		name = "pyright",
	})

	for _, client in ipairs(clients) do
		client.request("workspace/executeCommand", params, nil, 0)
	end
end

local function set_python_path(path)
	local clients = util.get_lsp_clients({
		bufnr = vim.api.nvim_get_current_buf(),
		name = "pyright",
	})
	for _, client in ipairs(clients) do
		if client.settings then
			client.settings.python = vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
		else
			client.config.settings =
				vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
		end
		client.notify("workspace/didChangeConfiguration", { settings = nil })
	end
end

lspconfig.pyright.setup({
	default_config = {
		cmd = { "pyright-langserver", "--stdio" },
		filetypes = { "python" },
		root_dir = util.root_pattern("pyproject.toml, setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git"),
		single_file_support = true,
		capabilities = capabilities,
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
})

lspconfig.clangd.setup({
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
		capabilities = capabilities,
	},
})

local pid = vim.fn.getpid()

local omnisharp_bin = "/usr/local/bin/omnisharp-roslyn/OmniSharp"

lspconfig.omnisharp.setup({
	capabilities = capabilities,
	cmd = { omnisharp_bin, "--languageserver", "--hostPID", pid, "--languages" },
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end,
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
})

local function get_typescript_server_path(root_dir)
	local project_root = vim.fs.dirname(vim.fs.find("node_modules", { path = root_dir, upward = true })[1])
	return project_root and (project_root .. "/node_modules/typescript/lib") or ""
end

lspconfig.volar.setup({
	cmd = { "vue-language-server", "--stdio" },
	init_options = {
		vue = {
			hybridMode = false,
		},
	},
	settings = {
		html = {
			format = {
				wrapAttributes = {
					enabled = true,
				},
			},
		},
		typescript = {
			inlayHints = {
				enumMemberValues = {
					enabled = true,
				},
				functionLikeReturnTypes = {
					enabled = true,
				},
				propertyDeclarationTypes = {
					enabled = true,
				},
				parameterTypes = {
					enabled = true,
					suppressWhenArgumentMatchesName = true,
				},
				variableTypes = {
					enabled = true,
				},
			},
		},
	},
	filetypes = { "vue" },
	root_dir = util.root_pattern("package.json"),
	on_new_config = function(new_config, new_root_dir)
		if
			new_config.init_options
			and new_config.init_options.typescript
			and new_config.init_options.typescript.tsdk == ""
		then
			new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
		end
	end,
})
