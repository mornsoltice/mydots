return {

"stevearc/oil.nvim",

dependencies = {

"nvim-tree/nvim-web-devicons",

},

lazy = false,

opts = {

columns = {

"icon",

"permissions",

"size",

"mtime",

},

view_options = {

show_hidden = true,

},

},

config = function()

require("oil").setup({

vim.keymap.set("n", "<leader>e", function()

require("oil").open()

end),

})

end,

}
