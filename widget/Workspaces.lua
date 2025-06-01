local Widget = require("astal.gtk3.widget")

return function()
	return Widget.Box({
		vertical = true,
		Widget.Button({
			Widget.Label({ label = "" }),
		}),
		Widget.Button({
			Widget.Label({ label = "" }),
		}),
		Widget.Button({
			Widget.Label({ label = "" }),
		}),
		Widget.Button({
			Widget.Label({ label = "" }),
		}),
		Widget.Button({
			Widget.Label({ label = "" }),
		}),
		Widget.Button({
			Widget.Label({ label = "" }),
		}),
		Widget.Button({
			Widget.Label({ label = "" }),
		})
	})
end
