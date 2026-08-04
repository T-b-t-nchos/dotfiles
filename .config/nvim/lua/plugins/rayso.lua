return {
    'TobinPalmer/rayso.nvim',
    cmd = { 'Rayso' },
    keys = {
        {
            "<leader>ss",
            "<cmd>Rayso<CR>",
            mode = "v",
            desc = "Export to Rayso",
        },
    },
    config = function()
        require('rayso').setup({})
    end
}
