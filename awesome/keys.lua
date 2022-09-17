local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")

local keys = {}

-- Mod keys
local superkey = "Mod4"
local altkey = "Mod1"
local ctrlkey = "Control"
local shiftkey = "Shift"

-- {{{ Key bindings
keys.globalkeys = gears.table.join(
-- Focus client by direction (hjkl keys)
  awful.key({ superkey }, "j",
    function()
      awful.client.focus.global_bydirection("down")
    end,
    { description = "focus down", group = "client" }),
  awful.key({ superkey }, "k",
    function()
      awful.client.focus.global_bydirection("up")
    end,
    { description = "focus up", group = "client" }),
  awful.key({ superkey }, "h",
    function()
      awful.client.focus.global_bydirection("left")
    end,
    { description = "focus left", group = "client" }),
  awful.key({ superkey }, "l",
    function()
      awful.client.focus.global_bydirection("right")
    end,
    { description = "focus right", group = "client" }),

  -- Window switcher
  awful.key({ superkey }, "Tab",
    function()
      awful.tag.history.restore()
    end,
    { description = "activate window switcher", group = "client" }),

  -- Focus client by index (cycle through clients)
  awful.key({ superkey }, "z",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by index", group = "client" }),

  awful.key({ superkey, shiftkey }, "z",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus next by index", group = "client" }),

  -- Gaps
  awful.key({ superkey, shiftkey }, "minus",
    function()
      awful.tag.incgap(5, nil)
    end,
    { description = "increment gaps size for the current tag", group = "gaps" }
  ),
  awful.key({ superkey }, "minus",
    function()
      awful.tag.incgap(-5, nil)
    end,
    { description = "decrement gap size for the current tag", group = "gaps" }
  ),

  -- Kill all visible clients for the current tag
  awful.key({ superkey, altkey }, "q",
    function()
      local clients = awful.screen.focused().clients
      for _, c in pairs(clients) do
        c:kill()
      end
    end,
    { description = "kill all visible clients for the current tag", group = "gaps" }
  ),

  -- No need for these (single screen setup)
  awful.key({ superkey, ctrlkey }, "l",
    function()
      client.focus:move_to_screen()
    end,
    { description = "move client to next screen", group = "screen" }),
  awful.key({ superkey, ctrlkey }, "h",
    function()
      local c = client.focus
      c:move_to_screen(c.screen.index - 1)
    end,
    { description = "move client to prev screen", group = "screen" }),

  -- Urgent or Undo:
  -- Jump to urgent client or (if there is no such client) go back
  -- to the last tag
  awful.key({ superkey, }, "u",
    function()
      local uc = awful.client.urgent.get()
      -- If there is no urgent client, go back to last tag
      if uc == nil then
        awful.tag.history.restore()
      else
        awful.client.urgent.jumpto()
      end
    end,
    { description = "jump to urgent client", group = "client" }),

  awful.key({ superkey, }, "x",
    function()
      awful.screen.focused().mypromptbox:run()
    end,
    { description = "go back", group = "tag" }),

  -- Spawn terminal
  awful.key({ superkey }, "Return", function() awful.spawn(terminal) end,
    { description = "open a terminal", group = "launcher" }),
  -- Spawn floating terminal
  awful.key({ superkey, shiftkey }, "Return", function()
    awful.spawn(terminal, { floating = true })
  end,
    { description = "spawn floating terminal", group = "launcher" }),

  -- Reload Awesome
  awful.key({ superkey, shiftkey }, "r", awesome.restart,
    { description = "reload awesome", group = "awesome" }),

  -- Quit Awesome
  -- Logout, Shutdown, Restart, Suspend, Lock
  awful.key({ superkey, shiftkey }, "x",
    function()
      exit_screen_show()
    end,
    { description = "quit awesome", group = "awesome" }),
  awful.key({ superkey }, "Escape",
    function()
      exit_screen_show()
    end,
    { description = "quit awesome", group = "awesome" }),
  awful.key({}, "XF86PowerOff",
    function()
      exit_screen_show()
    end,
    { description = "quit awesome", group = "awesome" }),

  -- Number of master clients
  awful.key({ superkey, altkey }, "h",
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    { description = "increase the number of master clients", group = "layout" }),
  awful.key({ superkey, altkey }, "l",
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ superkey, altkey }, "Left",
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    { description = "increase the number of master clients", group = "layout" }),
  awful.key({ superkey, altkey }, "Right",
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    { description = "decrease the number of master clients", group = "layout" }),

  -- Number of columns
  awful.key({ superkey, altkey }, "k",
    function()
      awful.tag.incncol(1, nil, true)
    end,
    { description = "increase the number of columns", group = "layout" }),
  awful.key({ superkey, altkey }, "j",
    function()
      awful.tag.incncol(-1, nil, true)
    end,
    { description = "decrease the number of columns", group = "layout" }),
  awful.key({ superkey, altkey }, "Up",
    function()
      awful.tag.incncol(1, nil, true)
    end,
    { description = "increase the number of columns", group = "layout" }),
  awful.key({ superkey, altkey }, "Down",
    function()
      awful.tag.incncol(-1, nil, true)
    end,
    { description = "decrease the number of columns", group = "layout" }),


  awful.key({ superkey }, "r", function() awful.layout.inc(1) end,
    { description = "select next", group = "layout" }),
  awful.key({ superkey, ctrlkey }, "r", function() awful.layout.inc(-1) end,
    { description = "select previous", group = "layout" }),

  awful.key({ superkey, shiftkey }, "n",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        client.focus = c
      end
    end,
    { description = "restore minimized", group = "client" }),

  -- Prompt
  --awful.key({ superkey },            "d",     function () awful.screen.focused().mypromptbox:run() end,
  --{description = "run prompt", group = "launcher"}),
  -- Run program (d for dmenu ;)
  awful.key({ superkey }, "space",
    function()
      awful.spawn.with_shell("rofi -matching fuzzy -show combi")
    end,
    { description = "rofi launcher", group = "launcher" }),

  -- Dismiss notifications and elements that connect to the dismiss signal
  awful.key({ ctrlkey }, "space",
    function()
      awesome.emit_signal("elemental::dismiss")
      naughty.destroy_all_notifications()
    end,
    { description = "dismiss notification", group = "notifications" }),

  -- Brightness
  awful.key({}, "XF86MonBrightnessDown",
    function()
      awful.spawn.with_shell("light -U 10")
    end,
    { description = "decrease brightness", group = "brightness" }),
  awful.key({}, "XF86MonBrightnessUp",
    function()
      awful.spawn.with_shell("light -A 10")
    end,
    { description = "increase brightness", group = "brightness" }),

  -- Volume Control with volume keys
  awful.key({}, "XF86AudioMute",
    function()
      helpers.volume_control(0)
    end,
    { description = "(un)mute volume", group = "volume" }),
  awful.key({}, "XF86AudioLowerVolume",
    function()
      helpers.volume_control(-5)
    end,
    { description = "lower volume", group = "volume" }),
  awful.key({}, "XF86AudioRaiseVolume",
    function()
      helpers.volume_control(5)
    end,
    { description = "raise volume", group = "volume" }),

  -- Volume Control with alt+F1/F2/F3
  awful.key({ altkey }, "F1",
    function()
      helpers.volume_control(0)
    end,
    { description = "(un)mute volume", group = "volume" }),
  awful.key({ altkey }, "F2",
    function()
      helpers.volume_control(-5)
    end,
    { description = "lower volume", group = "volume" }),
  awful.key({ altkey }, "F3",
    function()
      helpers.volume_control(5)
    end,
    { description = "raise volume", group = "volume" }),

  -- Microphone (V for voice)
  awful.key({ superkey }, "v",
    function()
      awful.spawn.with_shell("pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    end,
    { description = "(un)mute microphone", group = "volume" }),

  awful.key({}, "Print",
    function()
      awful.spawn("flameshot gui")
    end,
    { description = "print screen", group = "screen" }),
  -- Media keys
  awful.key({}, "XF86AudioNext", function() awful.spawn.with_shell("playerctl next") end,
    { description = "next song", group = "media" }),
  awful.key({}, "XF86AudioPrev", function() awful.spawn.with_shell("playerctl previous") end,
    { description = "previous song", group = "media" }),
  awful.key({}, "XF86AudioPlay", function() awful.spawn.with_shell("playerctl play-pause") end,
    { description = "toggle pause/play", group = "media" }),
  awful.key({}, "XF86AudioPause", function() awful.spawn.with_shell("playerctl play-pause") end,
    { description = "toggle pause/play", group = "media" }),
  -- Tiling
  awful.key({ superkey }, "s",
    function()
      awful.layout.set(awful.layout.suit.tile)
    end,
    { description = "set tiled layout", group = "tag" }),
  -- Set floating layout
  awful.key({ superkey, shiftkey }, "s", function()
    awful.layout.set(awful.layout.suit.floating)
  end,
    { description = "set floating layout", group = "tag" }),
  -- Editor
  awful.key({ superkey }, "e", function()
    awful.spawn(editor_cmd)
  end,
    { description = "editor", group = "launcher" })
)

keys.clientkeys = gears.table.join(
-- Move to edge or swap by direction
  awful.key({ superkey, shiftkey }, "j", function(c)
    helpers.move_client_dwim(c, "down")
  end),
  awful.key({ superkey, shiftkey }, "k", function(c)
    helpers.move_client_dwim(c, "up")
  end),
  awful.key({ superkey, shiftkey }, "h", function(c)
    helpers.move_client_dwim(c, "left")
  end),
  awful.key({ superkey, shiftkey }, "l", function(c)
    helpers.move_client_dwim(c, "right")
  end),

  -- Relative move client
  awful.key({ superkey, shiftkey, ctrlkey }, "j", function(c)
    c:relative_move(0, dpi(20), 0, 0)
  end),
  awful.key({ superkey, shiftkey, ctrlkey }, "k", function(c)
    c:relative_move(0, dpi(-20), 0, 0)
  end),
  awful.key({ superkey, shiftkey, ctrlkey }, "h", function(c)
    c:relative_move(dpi(-20), 0, 0, 0)
  end),
  awful.key({ superkey, shiftkey, ctrlkey }, "l", function(c)
    c:relative_move(dpi(20), 0, 0, 0)
  end),
  awful.key({ superkey, shiftkey, ctrlkey }, "Down", function(c)
    c:relative_move(0, dpi(20), 0, 0)
  end),
  awful.key({ superkey, shiftkey, ctrlkey }, "Up", function(c)
    c:relative_move(0, dpi(-20), 0, 0)
  end),
  awful.key({ superkey, shiftkey, ctrlkey }, "Left", function(c)
    c:relative_move(dpi(-20), 0, 0, 0)
  end),
  awful.key({ superkey, shiftkey, ctrlkey }, "Right", function(c)
    c:relative_move(dpi(20), 0, 0, 0)
  end),

  -- Toggle titlebars (for focused client only)
  awful.key({ superkey, }, "t",
    function(c)
      awful.titlebar.toggle(c, beautiful.titlebar_position)
    end,
    { description = "toggle titlebar", group = "client" }),
  -- Toggle titlebars (for all visible clients in selected tag)
  awful.key({ superkey, shiftkey }, "t",
    function(c)
      local clients = awful.screen.focused().clients
      for _, c in pairs(clients) do
        decorations.cycle(c)
      end
    end,
    { description = "toggle titlebar", group = "client" }),

  -- Toggle fullscreen
  awful.key({ superkey, }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),

  -- F for focused view
  awful.key({ superkey, ctrlkey }, "f",
    function(c)
      helpers.float_and_resize(c, screen_width * 0.7, screen_height * 0.75)
    end,
    { description = "focus mode", group = "client" }),
  -- V for vertical view
  awful.key({ superkey, ctrlkey }, "v",
    function(c)
      helpers.float_and_resize(c, screen_width * 0.45, screen_height * 0.90)
    end,
    { description = "focus mode", group = "client" }),
  -- T for tiny window
  awful.key({ superkey, ctrlkey }, "t",
    function(c)
      helpers.float_and_resize(c, screen_width * 0.3, screen_height * 0.35)
    end,
    { description = "tiny mode", group = "client" }),
  -- N for normal size (good for terminals)
  awful.key({ superkey, ctrlkey }, "n",
    function(c)
      helpers.float_and_resize(c, screen_width * 0.45, screen_height * 0.5)
    end,
    { description = "normal mode", group = "client" }),

  -- Close client
  awful.key({ superkey }, "w", function(c) c:kill() end,
    { description = "close", group = "client" }),
  awful.key({ altkey }, "F4", function(c) c:kill() end,
    { description = "close", group = "client" }),

  -- Toggle floating
  awful.key({ superkey, ctrlkey }, "space",
    function(c)
      local layout_is_floating = (awful.layout.get(mouse.screen) == awful.layout.suit.floating)
      if not layout_is_floating then
        awful.client.floating.toggle()
      end
    end,
    { description = "toggle floating", group = "client" }),

  -- Set master
  awful.key({ superkey, ctrlkey }, "Return", function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }),

  -- Change client opacity
  awful.key({ ctrlkey, superkey }, "o",
    function(c)
      c.opacity = c.opacity - 0.1
    end,
    { description = "decrease client opacity", group = "client" }),
  awful.key({ superkey, shiftkey }, "o",
    function(c)
      c.opacity = c.opacity + 0.1
    end,
    { description = "increase client opacity", group = "client" }),

  -- P for pin: keep on top OR sticky
  -- On top
  awful.key({ superkey, shiftkey }, "p", function(c) c.ontop = not c.ontop end,
    { description = "toggle keep on top", group = "client" }),
  -- Sticky
  awful.key({ superkey, ctrlkey }, "p", function(c) c.sticky = not c.sticky end,
    { description = "toggle sticky", group = "client" }),

  -- Minimize
  awful.key({ superkey, }, "n",
    function(c)
      c.minimized = true
    end,
    { description = "minimize", group = "client" }),

  -- Maximize
  awful.key({ superkey, }, "m",
    function(c)
      c.maximized = not c.maximized
    end,
    { description = "(un)maximize", group = "client" }),
  awful.key({ superkey, ctrlkey }, "m",
    function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end,
    { description = "(un)maximize vertically", group = "client" }),
  awful.key({ superkey, shiftkey }, "m",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end,
    { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local ntags = 10
for i = 1, ntags do
  keys.globalkeys = gears.table.join(keys.globalkeys,
    -- View tag only.
    awful.key({ superkey }, "#" .. i + 9,
      function()
        -- Tag back and forth
        helpers.tag_back_and_forth(i)

        -- Simple tag view
        -- local tag = mouse.screen.tags[i]
        -- if tag then
        -- tag:view_only()
        -- end
      end,
      { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ superkey, ctrlkey }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = "toggle tag #" .. i, group = "tag" }),

    -- Move client to tag.
    awful.key({ superkey, shiftkey }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = "move focused client to tag #" .. i, group = "tag" }),

    -- Move all visible clients to tag and focus that tag
    awful.key({ superkey, altkey }, "#" .. i + 9,
      function()
        local tag = client.focus.screen.tags[i]
        local clients = awful.screen.focused().clients
        if tag then
          for _, c in pairs(clients) do
            c:move_to_tag(tag)
          end
          tag:view_only()
        end
      end,
      { description = "move all visible clients to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ superkey, ctrlkey, shiftkey }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

-- Mouse buttons on the client (whole window, not just titlebar)
keys.clientbuttons = gears.table.join(
  awful.button({}, 1, function(c) client.focus = c end),
  awful.button({ superkey }, 1, awful.mouse.client.move),
  -- awful.button({ superkey }, 2, function (c) c:kill() end),
  awful.button({ superkey }, 3, function(c)
    client.focus = c
    awful.mouse.client.resize(c)
    -- awful.mouse.resize(c, nil, {jump_to_corner=true})
  end),

  -- Super + scroll = Change client opacity
  awful.button({ superkey }, 4, function(c)
    c.opacity = c.opacity + 0.1
  end),
  awful.button({ superkey }, 5, function(c)
    c.opacity = c.opacity - 0.1
  end)
)


-- Set root (desktop) keys
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

return keys
