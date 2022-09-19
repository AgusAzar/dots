local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local gears = require("gears")
local helpers = require("helpers")
local beautiful = require("beautiful")
local naughty = require("naughty")

mytextclock = wibox.widget.textclock()
-- battery widget
local bat_icon = wibox.widget {
  markup = "<span foreground='" .. x.color0 .. "'>⚡</span>",
  font = "Symbols Nerd Font " .. "10",
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox
}

local battery_progress = wibox.widget {
  color            = x.color2,
  background_color = x.foreground .. "00",
  forced_width     = dpi(27),
  border_width     = dpi(0.5),
  border_color     = x.foreground .. "A6",
  paddings         = dpi(2),
  bar_shape        = helpers.rrect(dpi(2)),
  shape            = helpers.rrect(dpi(4)),
  value            = 70,
  max_value        = 100,
  widget           = wibox.widget.progressbar,
}

local battery_border_thing = wibox.widget {
  wibox.widget.textbox,
  widget        = wibox.container.background,
  border_width  = dpi(0),
  bg            = x.foreground .. "A6",
  forced_width  = dpi(8),
  forced_height = dpi(8),
  shape         = function(cr, width, height)
    gears.shape.pie(cr, width, height, math.pi / 2, -math.pi / 2)
  end
}

local battery = wibox.widget {
  {
    {
      {
        battery_border_thing,
        widget = wibox.container.place
      },
      {
        {
          battery_progress,
          direction = "south",
          widget = wibox.container.rotate
        },
        layout = wibox.container.margin,
        margins = { top = dpi(5), bottom = dpi(5) }
      },
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(-5),
    },
    {
      bat_icon,
      margins = { top = dpi(3) },
      widget = wibox.container.margin,
    },
    layout = wibox.layout.fixed.horizontal,
  },
  widget = wibox.container.margin,
  margins = { left = dpi(7.47), right = dpi(7.47) }
}
-- Eo battery
screen.connect_signal("request::desktop_decoration", function(s)
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox {
    screen  = s,
    buttons = {
      awful.button({}, 1, function() awful.layout.inc(1) end),
      awful.button({}, 3, function() awful.layout.inc(-1) end),
      awful.button({}, 4, function() awful.layout.inc(-1) end),
      awful.button({}, 5, function() awful.layout.inc(1) end),
    }
  }

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = {
      awful.button({}, 1, function(t) t:view_only() end),
      awful.button({ modkey }, 1, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({ modkey }, 3, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),
      awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
      awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
    }
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen          = s,
    filter          = awful.widget.tasklist.filter.currenttags,
    buttons         = {
      awful.button({}, 1, function(c)
        c:activate { context = "tasklist", action = "toggle_minimization" }
      end),
      awful.button({}, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
      awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
      awful.button({}, 5, function() awful.client.focus.byidx(1) end),
    },
    style           = {
      shape_border_width = 1,
      shape_border_color = '#777777',
      shape              = gears.shape.rounded_bar,
    },
    layout          = {
      spacing        = 10,
      spacing_widget = {
        {
          forced_width = 5,
          shape        = gears.shape.circle,
          widget       = wibox.widget.separator
        },
        valign = 'center',
        halign = 'center',
        widget = wibox.container.place,
      },
      layout         = wibox.layout.flex.horizontal
    },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
      {
        {
          {
            {
              id     = 'icon_role',
              widget = wibox.widget.imagebox,
            },
            margins = 2,
            widget  = wibox.container.margin,
          },
          {
            id     = 'text_role',
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left   = 10,
        right  = 10,
        widget = wibox.container.margin
      },
      id     = 'background_role',
      widget = wibox.container.background,
    },
  }
  -----------------------------------------------------

  -- Create the wibox
  s.mywibox = awful.wibar {
    position = "top",
    screen   = s,
    widget   = {
      layout = wibox.layout.align.horizontal,
      expand = "none",
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        mylauncher,
        mytextclock,
        s.mypromptbox,
      },
      s.mytaglist,
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        wibox.widget.systray(),
        battery,
        s.mylayoutbox,
      },
    }
  }
end)


-- update widgets accordingly
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~
awesome.connect_signal("signal::battery", function(value, state)
  battery_progress.value = value
  if state == 1 then
    bat_icon.visible = true
  else
    bat_icon.visible = false
  end

end)
