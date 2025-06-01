local App = require("astal.gtk3.app")
local Hypr = require("lgi").require("AstalHyprland")
local Bar = require("widget.Bar")

local css_file = "./style.css";

App:start({
	css = css_file,
	main = function()
		Bar(0)
	end
})
