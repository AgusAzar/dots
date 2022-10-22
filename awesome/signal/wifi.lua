-- emits wifi status (with nmcli)
-- well, it works for me. so yeah
---------------------------------

-- ("signal::wifi"), function(net_status(bool))


-- rquirements
local awful = require("awful")

-- interval (in seconds)
local update_interval = 3

-- import network info
local net_cmd = [[
  bash -c "netctl-auto list | grep \*"
]]

awful.widget.watch(net_cmd, update_interval, function(_, stdout)
  local net_status = string.len(stdout) > 0
  -- emit (true or false)
  awesome.emit_signal("signal::wifi", net_status)
end)
