local Widget = require("astal.gtk3.widget")
local Anchor = require("astal.gtk3").Astal.WindowAnchor
local Workspaces = require("widget.Workspaces")
local Clock = require("widget.Clock")
local Battery = require("widget.Battery")


return function(monitor)
	if (monitor == nil) then
		print("Unable to get monitor")
		return nil
	end

	return Widget.Window({
		class_name = "app_win",
		monitor = monitor,
		anchor = Anchor.TOP + Anchor.BOTTOM + Anchor.LEFT,
		exclusivity = "EXCLUSIVE",
		Widget.CenterBox({
			class_name = "app_center_box",
			vertical = true,
			Widget.Box({
				vertical = true,
				class_name = "app_top",
				halign = "START",
				Clock("%H\n%M"),
			}),
			Widget.Box({
				class_name = "app_center",
				vertical = true,
				Workspaces(),
			}),
			Widget.Box({
				vertical = true,
				class_name = "app_bottom",
				halign = "END",
				Battery(),
			}),
		}),
	})
end
