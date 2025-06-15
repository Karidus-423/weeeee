local astal    = require("astal")
local bind     = astal.bind
local Widget   = require("astal.gtk3.widget")
local Hyprland = astal.require("AstalHyprland")
local hypr     = Hyprland.get_default()
local map      = require("lib").map;

--TODO: Change to make this fixed 7 buttons.
return function()
	return Widget.Box({
		class_name = "workspaces_box",
		vertical = true,
		--TODO:Default 7 workspaces.
		bind(hypr, "workspaces"):as(function(wss)
			table.sort(wss, function(a, b) return a.id < b.id end)

			return map(wss, function(ws)
				if not (ws.id >= -99 and ws.id <= -2) then -- filter out special workspaces
					return Widget.Box({
						class_name = bind(hypr, "focused-workspace"):as(
							function(fw) return fw == ws and "focused" or "unfocused" end
						),
						Widget.Label({
							label = bind(ws, "id"):as(
								function(v)
									return type(v) == "number"
										and string.format("", v)
										or string.format("h", v)
								end
							),
						})
					})
				end
			end)
		end),

	})
end
