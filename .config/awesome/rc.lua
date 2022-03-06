-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
require("awful.autofocus")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- require("awful.hotkeys_popup.keys")

require('errorhandling')
require('variables')
require('menu')
require('layouts')
require('wallpaper')
require('decoration')
require('globalkeys')
require('mousebindings')
require('keybindings')
require('rules')
require('titlebars')
require('notifications')
