local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local beautiful = require("beautiful")
local helpers = require("helpers")
local wbutton = require("ui.widgets.button")


return function (s)
  local date = os.date('*t')
  local calendar = wibox.widget{
    date = date,
    font = "Roboto  16",
    start_sunday = true,
    widget = wibox.widget.calendar.month
  }
	local widget = wibox.widget({
		{
			calendar,
			margins = dpi(16),
			widget = wibox.container.margin,
		},
		bg = beautiful.one_bg3,
		shape = helpers.ui.rrect(beautiful.border_radius),
		widget = wibox.container.background,
	})
  return widget
end
