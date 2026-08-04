return {
    "yuttie/comfortable-motion.vim",
    keys = {
        { "<C-d>", "<cmd>call comfortable_motion#flick(100)<CR>" },
        { "<C-u>", "<cmd>call comfortable_motion#flick(-100)<CR>" },
        { "<C-f>", "<cmd>call comfortable_motion#flick(200)<CR>" },
        { "<C-b>", "<cmd>call comfortable_motion#flick(-200)<CR>" },
    },
}
