return {
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
}
