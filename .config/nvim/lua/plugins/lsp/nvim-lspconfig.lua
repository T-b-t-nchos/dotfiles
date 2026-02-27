return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        "Hoffs/omnisharp-extended-lsp.nvim",

    },
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "Mason" },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        vim.lsp.handlers["textDocument/semanticTokens/full"] =
        vim.lsp.with(vim.lsp.semantic_tokens.full, {})

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client.server_capabilities.semanticTokensProvider then
                    vim.lsp.semantic_tokens.start(args.buf, client.id)
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
            },
        })

        -- mason 管理の LSP
        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
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
        }

        for name, config in pairs(servers) do
            vim.lsp.config(name, vim.tbl_extend("force", {
                capabilities = capabilities,
            }, config))
            vim.lsp.enable(name)
        end

        -- nvim-cmp
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            }),
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            },
        })
    end,
}
