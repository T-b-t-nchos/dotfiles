return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-emoji",
            "ray-x/cmp-treesitter",
            "saadparwaiz1/cmp_luasnip",

            "hrsh7th/cmp-cmdline",

            "L3MON4D3/LuaSnip",
            "onsails/lspkind.nvim",
        },
        event = { "InsertEnter", "CmdLineEnter" },
        config = function()
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

                    ["<Tab>"] = cmp.mapping(function(fallback)

                        -- cmp候補が見えている
                        if cmp.visible() then
                            cmp.select_next_item()
                            return
                        end

                        -- supermaven候補
                        local ok, sm = pcall(require, "supermaven-nvim.completion_preview")
                        if ok and sm.has_suggestion() then
                            sm.on_accept_suggestion()
                            return
                        end

                        fallback()
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),

                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "nvim_lsp_document_symbol" },
                    { name = "emoji" },
                    { name = "treesitter" },
                    { name = "luasnip" },
                },

                window = {
                    completion = {
                        winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpMenuSel",
                    }
                },
            })

            -- `/` cmdline setup.
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
            -- `:` cmdline setup.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                },
                {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' }
                        }
                    }
                }),
                formatting = {
                    format = function(entry, item)
                        local label = item.abbr or item.word

                        if vim.fn.isdirectory(label) == 1 then
                            item.kind = "Folder"
                        elseif label:match("%.[%w%d]+$") then
                            item.kind = "File"
                        else
                            item.kind = "Function"
                        end

                        return item
                    end,
                }
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "Hoffs/omnisharp-extended-lsp.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "Mason" },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.server_capabilities.semanticTokensProvider then
                        vim.lsp.semantic_tokens.enable(true, { bufnr = args.buf })
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
                },
            })

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
        "onsails/lspkind.nvim",
        event = "InsertEnter",
        config = function()
            require('lspkind').init({
            })
        end,
    },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
    }
}
