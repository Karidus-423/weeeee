local astal = require("astal")
local Widget = require("astal.gtk3.widget")
local Variable = astal.Variable
local GLib = astal.require("GLib")
local bind = astal.bind
local Mpris = astal.require("AstalMpris")
local Battery = astal.require("AstalBattery")
local Wp = astal.require("AstalWp")
local Network = astal.require("AstalNetwork")
local Hyprland = astal.require("AstalHyprland")
local map = require("lib").map

local function Wifi()
	local network = Network.get_default()
	local wifi = bind(network, "wifi")

	return Widget.Box({
		visible = wifi:as(function(v) return v ~= nil end),
		wifi:as(
			function(w)
				return Widget.Icon({
					tooltip_text = bind(w, "ssid"):as(tostring),
					class_name = "Wifi",
					icon = bind(w, "icon-name"),
				})
			end
		),
	})
end

local function AudioSlider()
	local speaker = Wp.get_default().audio.default_speaker

	return Widget.Box({
		class_name = "AudioSlider",
		css = "min-width: 140px;",
		Widget.Icon({
			icon = bind(speaker, "volume-icon"),
		}),
		Widget.Slider({
			hexpand = true,
			on_dragged = function(self) speaker.volume = self.value end,
			value = bind(speaker, "volume"),
		}),
	})
end

local function BatteryLevel()
	local bat = Battery.get_default()

	return Widget.Box({
		class_name = "Battery",
		visible = bind(bat, "is-present"),
		Widget.Icon({
			icon = bind(bat, "battery-icon-name"),
		}),
		Widget.Label({
			label = bind(bat, "percentage"):as(
				function(p) return tostring(math.floor(p * 100)) .. " %" end
			),
		}),
	})
end

local function Media()
	local player = Mpris.Player.new("spotify")

	return Widget.Box({
		class_name = "Media",
		visible = bind(player, "available"),
		Widget.Box({
			class_name = "Cover",
			valign = "CENTER",
			css = bind(player, "cover-art"):as(
				function(cover)
					return "background-image: url('" .. (cover or "") .. "');"
				end
			),
		}),
		Widget.Label({
			label = bind(player, "metadata"):as(
				function()
					return (player.title or "")
						.. " - "
						.. (player.artist or "")
				end
			),
		}),
	})
end

local function Workspaces()
	local hypr = Hyprland.get_default()

	return Widget.Box({
		class_name = "Workspaces",
		bind(hypr, "workspaces"):as(function(wss)
			table.sort(wss, function(a, b) return a.id < b.id end)

			return map(wss, function(ws)
				if not (ws.id >= -99 and ws.id <= -2) then -- filter out special workspaces
					return Widget.Button({
						class_name = bind(hypr, "focused-workspace"):as(
							function(fw) return fw == ws and "focused" or "" end
						),
						on_clicked = function() ws:focus() end,
						label = bind(ws, "id"):as(
							function(v)
								return type(v) == "number"
									and string.format("%.0f", v)
									or v
							end
						),
					})
				end
			end)
		end),
	})
end

local function Time(format)
	local time = Variable(""):poll(
		1000,
		function() return GLib.DateTime.new_now_local():format(format) end
	)

	return Widget.Label({
		class_name = "Time",
		on_destroy = function() time:drop() end,
		label = time(),
	})
end

return function(gdkmonitor)
	local Anchor = astal.require("Astal").WindowAnchor

	return Widget.Window({
		class_name = "Bar",
		gdkmonitor = gdkmonitor,
		anchor = Anchor.TOP + Anchor.LEFT + Anchor.RIGHT,
		-- anchor = Anchor.LEFT + Anchor.TOP + Anchor.BOTTOM,
		exclusivity = "EXCLUSIVE",
		Widget.CenterBox({
			Widget.Box({
				halign = "START",
				Media(),
			}),
			Widget.Box({
				Workspaces(),
			}),
			Widget.Box({
				halign = "END",
				Wifi(),
				AudioSlider(),
				BatteryLevel(),
				Time("%H:%M - %A %e."),
			}),
		}),
	})
end
