local App = require("astal.gtk3.app")
local Hypr = require("lgi").require("AstalHyprland")
local Bar = require("widget.Bar")

App:start({
	main = function()
		Bar(0)
	end
})
