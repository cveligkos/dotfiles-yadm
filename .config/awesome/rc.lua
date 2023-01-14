-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
require("awful.autofocus")

require("main.error-handling")
require("main.theme")
-- require('main.user-variables')
require("main.notifications")
require("main.rules")
require("main.signals")
require("main.tags")
require("main.menu")

require("decoration.decoration")
-- require('decoration.titlebar')

require("bindings.globalkeys")
require("bindings.globalbuttons")
require("bindings.clientkeys")
require("bindings.clientbuttons")
