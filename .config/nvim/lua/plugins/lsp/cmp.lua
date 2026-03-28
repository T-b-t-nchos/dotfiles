return {
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
    event = "InsertEnter",
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
            })
        })
    end,
}
