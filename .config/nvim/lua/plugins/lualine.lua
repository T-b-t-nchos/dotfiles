return {
    'nvim-lualine/lualine.nvim',
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local function char_count()
            local buf = vim.api.nvim_get_current_buf()
            local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

            local count = 0
            for _, line in ipairs(lines) do
                count = count + vim.fn.strchars(line)
            end

            return string.format("Char: %d", count)
        end

        require("lualine").setup({
            options = {
                theme = "auto",
            },
            sections = {
                lualine_c = {
                    char_count,
                },
            },
        })

        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators   = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },

            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', 'filetype', 'progress' },
                lualine_y = { char_count },
                lualine_z = { 'location' },
            },

            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {},
            },

            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })
    end,
}
