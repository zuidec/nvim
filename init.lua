require("svens")
local home_dir = os.getenv("HOME")
package.path = home_dir ..  "/.config/nvim/after/plugin/?.lua"
require("svens.colors").set_color()
