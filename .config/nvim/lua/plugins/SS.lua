return {
    "T-b-t-Nchos/ss-rubi.nvim",
    -- dir = "~/source/repos/ss-rubi.nvim",
    cmd = { "RubiInsert", "RubiInsertAC" },
    dev = false,
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
