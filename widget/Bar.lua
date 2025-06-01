local Widget = require("astal.gtk3.widget")
local Anchor = require("astal.gtk3").Astal.WindowAnchor
local Workspaces = require("widget.Workspaces")


return function(monitor)
	return Widget.Window({
		monitor = monitor,
		anchor = Anchor.TOP + Anchor.BOTTOM + Anchor.LEFT,
		exclusivity = "EXCLUSIVE",
		Widget.CenterBox({
			vertical = true,
			Widget.Box({
				halign = "START",
				Widget.Label({ label = "12\n00\nPM" }),
			}),
			Widget.Box({
				Workspaces()
			}),
			Widget.Box({
				halign = "END",
			}),
		}),
	})
end
