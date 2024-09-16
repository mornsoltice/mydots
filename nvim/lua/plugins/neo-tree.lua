return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<C-n>", ":Neotree toggle<CR>", silent = true , desc = "File Explorer"},
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            window = {
                position = "left",
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        "node_modules",
                    },
                    never_show = {
                        ".DS_Store",
                        "thumbs.db",
                    },
                },
            },
        })
    end,
}
