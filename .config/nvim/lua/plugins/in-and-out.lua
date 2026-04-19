return {
	"ysmb-wtsg/in-and-out.nvim",
	keys = { "<C-CR>", },
    event = "InsertEnter",
    opts = {
        additional_targets = {
            "”", "“",
            "‘", "’",
            "`",
            "「", "」",
            "『", "』",
            "【", "】",
            "（", "）",
            "｛", "｝",
            "［", "］",
            "＜", "＞",
            "‹", "›",
            "《", "》",
            "〈", "〉",
            "〔", "〕",
        }
    },
}

