local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local user_variables = require("main.user-variables")

local modkey = user_variables.modkey

local key = awful.key
-- General Awesome keys
awful.keyboard.append_global_keybindings({
	key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),

	key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),
})

-- Program launching keybindings
awful.keyboard.append_global_keybindings({
	key({ modkey }, "Return", function()
		awful.spawn(user_variables.terminal)
	end, { description = "open a terminal", group = "launcher" }),

	key({ modkey }, "r", function()
		awful.screen.focused().mypromptbox:run()
	end, { description = "run prompt", group = "launcher" }),

	key({ modkey }, "p", function()
		awful.spawn(user_variables.launcher_cmd)
	end, { description = "open program launcher", group = "launcher" }),

	key({ modkey }, "w", function()
		awful.spawn("firefox")
	end, { description = "open firefox", group = "launcher" }),

	key({ modkey }, "F8", function()
		awful.spawn.with_shell("$HOME/bin/chromium-launcher")
	end, { description = "open chromium profile selector", group = "launcher" }),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
	key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),

	key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),

	key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
	key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),

	key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),

	key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),

	key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),

	key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:activate({ raise = true, context = "key.unminimize" })
		end
	end, { description = "restore minimized", group = "client" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
	key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),

	key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),

	key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

	key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),

	key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),

	key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),

	key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),

	key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),

	key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),

	key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),

	key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),
})

-- Multimedia keys
awful.keyboard.append_client_keybindings({
	key({}, "XF86AudioLowerVolume", function()
		awful.spawn("pactl set-sink-volume 0 -5%")
	end, { description = "Lower volume by 5%", group = "media" }),

	key({}, "XF86AudioRaiseVolume", function()
		awful.spawn("pactl set-sink-volume 0 +5%")
	end, { description = "Raise volume by 5%", group = "media" }),

	key({}, "XF86AudioMute", function()
		awful.spawn("pactl set-sink-mute 0 toggle")
	end, { description = "Toggle mute", group = "media" }),

	key({}, "XF86AudioPlay", function()
		awful.spawn("playerctl --player=spotify,%any play-pause")
	end, { description = "Toggle play/pause", group = "media" }),

	key({}, "XF86AudioPrev", function()
		awful.spawn("playerctl --player=spotify,%any previous")
	end, { description = "Play previous track", group = "media" }),

	key({}, "XF86AudioNext", function()
		awful.spawn("playerctl --player=spotify,%any next")
	end, { description = "Play next track", group = "media" }),
})

awful.keyboard.append_global_keybindings({
	key({
		modifiers = { modkey },
		keygroup = "numrow",
		description = "only view tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),

	key({
		modifiers = { modkey, "Control" },
		keygroup = "numrow",
		description = "toggle tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	}),

	key({
		modifiers = { modkey, "Shift" },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),

	key({
		modifiers = { modkey, "Control", "Shift" },
		keygroup = "numrow",
		description = "toggle focused client on tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end,
	}),

	key({
		modifiers = { modkey },
		keygroup = "numpad",
		description = "select layout directly",
		group = "layout",
		on_press = function(index)
			local t = awful.screen.focused().selected_tag
			if t then
				t.layout = t.layouts[index] or t.layout
			end
		end,
	}),
})
