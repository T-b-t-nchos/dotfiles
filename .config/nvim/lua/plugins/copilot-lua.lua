return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "BufReadPost", "BufNewFile"},

    config = function()
        require("copilot").setup({
            suggestion = {
                enabled = true,
                keymap = {
                    accept = "<Tab>",
                    dismiss = "<C-e>",
                }
            }
        })
    end,
}
