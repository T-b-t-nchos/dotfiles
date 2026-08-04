return {
    'brianhuster/live-preview.nvim',
    cmd = 'LivePreview',
    keys = {
        { "<leader>pl", "<cmd>LivePreview start<cr>", desc = "Live Preview" },
    },
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
}
