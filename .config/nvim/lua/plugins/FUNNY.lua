return {
    {
        "seandewar/bad-apple.nvim",
        cmd = "BadApple", -- コマンドが呼ばれたときにのみロード  
        config = function() end,
    },
    {
        "Eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton",
    },
    {
        'njegg/dvd.nvim',
        cmd = "CellularAutomaton",
        depandencies = {
            {'eandrju/cellular-automaton.nvim'},
            {'uga-rosa/utf8.nvim'}
        },
    },
    {
        'alec-gibson/nvim-tetris',
        cmd = 'Tetris'
    },
    {
        'leonardo-luz/snake.nvim',
        cmd = "Snake",
        dependencies = {
            {
                'leonardo-luz/floatwindow.nvim',
                'nvim-lua/plenary.nvim',
            },
        },
        opts = {
            wall_collision = false,
            speed = 100,
            map_size = {
                x = 90,
                y = 30,
            },
            max_foods = 10,
            spawn_rate = 5,
            highscore_persistence = false,
            visual = {
                head = {
                    "^",
                    ">",
                    "v",
                    "<"
                },
                body = "+",
                food = "x",
                start_pos = "o",
                wall = "*",
                background = " ",
            }
        }
    },
    {
        "Pansther/minesweeper.nvim",
        cmd = "Minesweeper",
        config = function()
            require("minesweeper").setup()
        end,
    }
}
