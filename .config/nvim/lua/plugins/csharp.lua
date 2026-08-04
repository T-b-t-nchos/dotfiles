return {
    {
        "iabdelkareem/csharp.nvim",
        module = "csharp",
        ft = { "cs" },
        keys = {
            {
                "<leader>#d",
                function()
                    require("csharp").debug_project()
                end,
                desc = "Debug Project",
            },
            {
                "<leader>#r",
                function()
                    require("csharp").run_project()
                end,
                desc = "Run Project",
            },
            {
                "<leader>#u",
                function()
                    require("csharp").fix_usings()
                end,
                desc = "Fix Usings",
            },
        },
        dependencies = {
            "williamboman/mason.nvim", -- Required, automatically installs omnisharp
            "mfussenegger/nvim-dap",
            "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
        },
        config = function ()
            require("csharp").setup({
                lsp = {
                    enable = false,
                },
            })
        end
    },
    {
        "MonsieurTib/neonuget",
        cmd = "Nuget",
        ft = { "cs", "fs", "fsi", "fsscript", "fsx", "nupkg", ".csproj", ".fsproj", ".vbproj", ".sln", ".slnx" },
        keys = {
            { "<leader>#n", "<cmd>Nuget<cr>", desc = "NeoNuGet" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("neonuget").setup({
                dotnet_path = "dotnet",
                default_project = nil,
            })
        end,
    },
}
