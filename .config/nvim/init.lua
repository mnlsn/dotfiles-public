if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd
vim.o.termguicolors = true
vim.cmd([[set mouse=a]])

require("config.lazy")
require("nelsooon.lsp")
require("nelsooon.options")
