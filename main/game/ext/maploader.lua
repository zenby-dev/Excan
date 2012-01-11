---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 1/10/12
-- Time: 7:32 PM
--

local MLTypeFuncs = {}

function LoadMapFile(path)
	try(function() love.filesystem.exists(path) end)

	local tab = loadtable(path)

	MAP = {}

	MAP.Name = tab.name
	MAP.State = GetState()

	for _, tag in pairs(tab.con) do

		if MLTypeFuncs[type(tag)] then

			MLTypeFuncs[type(tag)](tag)

		end

	end

end

MLTypeFuncs["Scenery"] = function(var)

	local spr = Scenery(var.pos, var.path, var.layer or 0, var.anim or "", var.scale or Vec2(1, 1))

end