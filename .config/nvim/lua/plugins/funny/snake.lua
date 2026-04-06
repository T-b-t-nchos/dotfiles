return {
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
}
