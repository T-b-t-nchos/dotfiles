return {
    "SayC8/license_gen.nvim",
    cmd = "AddLicense",
    config = function()
        require("license_gen").setup({
        })
    end
}
