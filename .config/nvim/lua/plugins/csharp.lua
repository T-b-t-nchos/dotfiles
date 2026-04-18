return {
    {
        "iabdelkareem/csharp.nvim",
        module = "csharp",
        ft = { "cs" },
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
