local awful = require("awful")
local update_interval = 30

-- Subscribe to power supply status changes with acpi_listen
local charger_script = [[
    sh -c '
    acpi_listen | grep --line-buffered ac_adapter
    '
]]

local charger = 0
local percentage = 0

--check battery
awful.spawn.easy_async_with_shell("sh -c 'out=\"$(find /sys/class/power_supply/BAT?/capacity)\" && (echo \"$out\" | head -1) || false' "
  , function(battery_file, _, __, exit_code)
  -- No battery file found
  if not (exit_code == 0) then
    return
  end
  -- Periodically get battery info
  awful.widget.watch("cat " .. battery_file, update_interval, function(_, stdout)
    local percentage = tonumber(stdout)
    awful.spawn.easy_async_with_shell("sh -c 'out=\"$(find /sys/class/power_supply/*/online)\" && (echo \"$out\" | head -1) || false' "
      , function(charger_file, _, __, exit_code)
      awful.spawn.easy_async_with_shell("cat " .. charger_file, function(out)
        local charger = tonumber(out)
        awesome.emit_signal("signal::battery", percentage, charger)
      end)
    end)
  end)
end)
