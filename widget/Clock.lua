local astal    = require("astal")
local Variable = astal.Variable
local GLib     = astal.require("GLib")
local Widget   = require("astal.gtk3.widget")

return function(format)
	local time = Variable(""):poll(
		6000,
		function()
			return GLib.DateTime.new_now_local():format(format)
		end
	)
	return Widget.Box({
		class_name = "time_box",
		Widget.Label({
			class_name = "time_label",
			label = time(),
		})
	})
end
