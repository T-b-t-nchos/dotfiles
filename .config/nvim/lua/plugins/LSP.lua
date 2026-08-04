return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
            "Hoffs/omnisharp-extended-lsp.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "Mason" },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    if client
                        and client.server_capabilities.semanticTokensProvider
                        then
                            vim.lsp.semantic_tokens.enable(true, {
                                bufnr = args.buf,
                            })
                        end
                    end,
                })

                require("mason").setup()

                require("mason-lspconfig").setup({
                    ensure_installed = {
                        "lua_ls",
                        "pyright",
                        "clangd",
                        "jsonls",
                        "marksman",
                        "omnisharp",
                        "tailwindcss",
                        "cssls",
                        "html",
                        "jdtls",
                        "ts_ls",
                        "phpactor",
                        "yamlls",
                        "bashls",
                        "powershell_es",
                        "gh_actions_ls",
                    },
                })

                local servers = {
                    lua_ls = {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                            },
                        },
                    },

                    pyright = {},
                    clangd = {},
                    jsonls = {},
                    marksman = {},

                    omnisharp = {
                        omnisharp = {
                            cmd = {
                                "omnisharp",
                                "--languageserver",
                                "--stdio",
                                "--hostPID",
                                tostring(vim.fn.getpid()),
                            },
                        },

                        handlers = {
                            ["textDocument/definition"] =
                            require("omnisharp_extended").handler,
                        },

                        enable_import_completion = true,
                        enable_roslyn_analyzers = true,
                        organize_imports_on_format = true,
                        enable_editorconfig_support = true,

                        settings = {
                            FormattingOptions = {
                                EnableEditorConfigSupport = true,
                                OrganizeImports = true,
                            },

                            MsBuild = {
                                LoadProjectsOnDemand = true,
                            },

                            RoslynExtensionsOptions = {
                                EnableAnalyzersSupport = true,
                                EnableImportCompletion = true,
                                AnalyzeOpenDocumentsOnly = true,
                            },

                            Sdk = {
                                IncludePrereleases = true,
                            },
                        },
                    },

                    tailwindcss = {},
                    cssls = {},
                    html = {},
                    jdtls = {},
                    ts_ls = {},
                    phpactor = {},
                    yamlls = {},
                    bashls = {},
                    powershell_es = {},
                }

                for name, config in pairs(servers) do
                    vim.lsp.config(name, vim.tbl_extend(
                        "force",
                        {
                            capabilities = capabilities,
                        },
                        config
                    ))

                    vim.lsp.enable(name)
                end
            end,
        },

        {
            "ray-x/lsp_signature.nvim",
            event = "LspAttach",
            opts = {
                bind = true,
                floating_window = true,
                hint_enable = false,
            },
        },

        {
            "folke/trouble.nvim",
            opts = {},
            cmd = "Trouble",
            keys = {
                { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics" },
                { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics" },
                { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols" },
                { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", desc = "LSP" },
                { "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Location List" },
                { "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix List" },
            },

        },
    }
