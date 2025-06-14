local astal   = require("astal")
local Battery = astal.require("AstalBattery")
local Widget  = require("astal.gtk3.widget")
local bind    = astal.bind

return function()
	local bat = Battery.get_default()

	return Widget.Box({
		class_name = "Battery",
		vertical = true,
		visible = bind(bat, "is-present"),
		Widget.Icon({
			icon = bind(bat, "battery-icon-name"),
		}),
		Widget.Label({
			label = bind(bat, "percentage"):as(
				function(p) return tostring(math.floor(p * 100)) end
			),
		}),
	})
end
