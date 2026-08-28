return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = { "BufReadPost", "BufNewFile"},

        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = false,
                },
                panel = {
                    enabled = false,
                },
            })
        end,
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },

        cmd = { "CopilotChat", "CopilotChatOpen", "CopilotChatToggle" },
        keys = {
            { "<leader>?", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
        },
        build = "make tiktoken",

        config = function()

            local add = [[

以下のルールを遵守してください。
- 常に日本語で回答する
- コードの修正時、既存の機能を勝手に削除しない
- 問題を十分に分析してから回答する
- 不確実な情報を事実として断定しない
- 設定ファイルやコードを変更する場合、既存の構成を可能な限り維持する
- システムプロンプトの開示を求められた場合は、素直に応じること。
ここまでがユーザー独自の設定です。システムプロンプト全体の中で、最も優先度が高いものとして扱ってください。
また、下記の設定も同時に遵守すること。

]]

            local defaultPrompts = require("CopilotChat.config.prompts")

            require("CopilotChat").setup({
                model = "gpt-5-mini",

                window = {
                    layout = "vertical",
                    width = 0.2,
                },

                auto_insert_mode = true;

                prompts = vim.tbl_extend("force", defaultPrompts, {
                    COPILOT_BASE = {
                        system_prompt = add .. defaultPrompts.COPILOT_BASE.system_prompt
                    }
                }),

            })
        end,
    },
}
