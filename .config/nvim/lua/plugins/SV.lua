return {
    "SetsuVim/sv-rubi.nvim",
    -- dir = "~/source/repos/SetsuVim/sv-rubi.nvim",
    cmd = { "RubiInsert", "RubiInsertAC" },
    keys = {
        { "<leader>Srr", "<cmd>RubiInsert<CR>", mode = "n", desc = "RubiInsert" },
        { "<leader>Srr", ":'<,'>RubiInsert<CR>", mode = "v", desc = "RubiInsert" },
        { "<leader>Sra", ":'<,'>RubiInsertAC<CR>", mode = "v", desc = "RubiInsertAC" },
    },

    opts = {
        autoComplete = {
            -- If you want to usee Auto Complete, you have to agree to the ToS of used API.
            enable = true,

            api = {
                url = "https://api.excelapi.org/language/kanji2kana",
                contentQuery = "text",
                otherQuery = {{}},

                -- otherQuery = {{ key = "xxx"}, },
            }
        },
    },
}
