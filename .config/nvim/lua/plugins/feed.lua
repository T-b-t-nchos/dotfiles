return {
    "neo451/feed.nvim",
    cmd = "Feed",
    opts = {
        feeds = {
            "https://forest.watch.impress.co.jp/data/rss/1.0/wf/feed.rdf",
            "https://gigazine.net/news/rss_2.0/",
            "https://www.gizmodo.jp/index.xml",
        },
        search = {
            backend = "telescope",
        },
    },
}
