return {
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     priority = 1000,
    --     config = function()
    --         require("catppuccin").setup({
    --             flavour = "mocha",
    --             auto_integrations = true,
    --             transparent_background = true,
    --             color_overrides = {
    --                 mocha = {
    --                     base = "#12121a",
    --                     mantle = "#12121a",
    --                     crust = "#12121a",
    --                 },
    --             },
    --         })
    --         -- vim.cmd.colorscheme("catppuccin-mocha")
    --
    --         vim.cmd("highlight TelescopeSelection cterm=bold gui=bold guifg=#a6e3a1 guibg=#181825")
    --         vim.cmd("hi VertSplit cterm=none")
    --     end,
    -- },

    -- "EdenEast/nightfox.nvim",
    -- name = "nightfox",
    -- priority = 1000,
    -- config = function ()
    --     require('nightfox').setup({
    --         options = {
    --             transparent = true,
    --         }
    --     })
    --
    --     vim.cmd.colorscheme("Nordfox")
    -- end

    {
        "cpea2506/one_monokai.nvim",
        name = "one_monokai",
        priority = 1000,
        config = function ()
            require("one_monokai").setup({
                transparent = true,
                colors = { -- optimize for transparent-background.
                    fg = "#cdd5e5",
                    gray = "#a1abbf",
                    dark_gray = "#687287"
                },
                highlights = function(colors)
                    return {}
                end,
                bold = true,
                italics = true,
            })
            vim.cmd.colorscheme("one_monokai")
            vim.o.winborder = "single"
        end
    }

    -- "FrenzyExists/aquarium-vim",
    -- name = "aquarium-vim",
    -- priority = 1000,
    -- config = function ()
    --     vim.g.aqua_bold = 1
    --     vim.g.aqua_transparency = 1
    --     vim.g.aquarium_style = "light" -- "light" も可
    --
    --     vim.cmd.colorscheme("aquarium")
    -- end

    -- "AlexvZyl/nordic.nvim",
    -- name = "nordic",
    -- priority = 1000,
    -- config = function ()
    --     require('nordic').setup({
    --         transparent = {
    --             bg = true,
    --             float = true,
    --         },
    --         reduced_blue = true,
    --     })
    --
    --     vim.cmd.colorscheme("nordic")
    -- end

    -- "shaunsingh/nord.nvim",
    -- name = "nord",
    -- priority = 1000,
    -- config = function ()
    --     vim.g.nord_contrast = true
    --     vim.g.nord_borders = true
    --     vim.g.nord_disable_background = true
    --     vim.g.nord_italic = true
    --     vim.g.nord_uniform_diff_background = true
    --     vim.g.nord_bold = false
    --     vim.cmd.colorscheme("nord")
    -- end,


    --[[
    "daschw/leaf.nvim",
    name = "leaf",
    priority = 1000,
    config = function()
        require("leaf").setup({
            underlineStyle = "underline",
            commentStyle = "italic",
            functionStyle = "NONE",
            keywordStyle = "italic",
            statementStyle = "bold",
            typeStyle = "NONE",
            variablebuiltinStyle = "italic",
            transparent = true,
            colors = {},
            overrides = {},
            theme = "dark", -- default, based on vim.o.background, alternatives: "light", "dark"
            contrast = "low", -- default, alternatives: "medium", "high"
        })
        vim.cmd.colorscheme("leaf")
    end,
    ]]
 
    --[[
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,
    config = function()
        require("gruvbox").setup({
            terminal_colors = true, -- add neovim terminal colors
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
            strings = true,
            emphasis = true,
            comments = true,
            operators = false,
            folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = true,
        })
        vim.cmd.colorscheme("gruvbox")
    end,
    ]]

    --[[
    {
      'sainnhe/sonokai',
      priority = 1000,
      config = function()
        vim.g.sonokai_enable_italic = true
        vim.g.sonokai_style = 'andromeda'
        vim.g.sonokai_transparent_background = 1

        vim.cmd('colorscheme sonokai')

        local hl = vim.api.nvim_set_hl

        -- 基本
        hl(0, 'Normal',        { bg = 'none' })
        hl(0, 'NormalNC',      { bg = 'none' })
        hl(0, 'EndOfBuffer',   { bg = 'none' })
        hl(0, 'SignColumn',    { bg = 'none' })
        hl(0, 'LineNr',        { bg = 'none' })
        hl(0, 'CursorLineNr',  { bg = 'none' })

        -- Float / Popup（catppuccin が丁寧なところ）
        hl(0, 'NormalFloat',   { bg = 'none' })
        hl(0, 'FloatBorder',   { bg = 'none' })
        hl(0, 'Pmenu',         { bg = 'none' })
        hl(0, 'PmenuSel',      { bg = 'none' })
        hl(0, 'PmenuSbar',     { bg = 'none' })
        hl(0, 'PmenuThumb',    { bg = 'none' })

        -- Telescope
        hl(0, 'TelescopeNormal',       { bg = 'none' })
        hl(0, 'TelescopeBorder',       { bg = 'none' })
        hl(0, 'TelescopePromptNormal', { bg = 'none' })
        hl(0, 'TelescopeResultsNormal',{ bg = 'none' })
        hl(0, 'TelescopePreviewNormal',{ bg = 'none' })

        -- ステータス / 分割線
        hl(0, 'StatusLine',   { bg = 'none' })
        hl(0, 'StatusLineNC', { bg = 'none' })
        hl(0, 'WinSeparator', { bg = 'none' })
      end,
    }
    ]]

}
