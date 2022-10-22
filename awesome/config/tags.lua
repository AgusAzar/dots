-- tags  / layouts
-- ~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local awful = require("awful")


-- misc/vars
-- ~~~~~~~~~



-- names/numbers of layouts
local names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
local l     = awful.layout.suit


-- Configurations
-- **************

-- default tags
tag.connect_signal("request::default_layouts", function()

  awful.layout.append_default_layouts({
    l.tile, l.floating
  })

end)


-- set tags
screen.connect_signal("request::desktop_decoration", function(s)
  screen[s].padding = { left = 0, right = 0, top = 0, bottom = 0 }
  awful.tag(names, s, awful.layout.layouts[1])
end)
