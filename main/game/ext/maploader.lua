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

--[[MLTypeFuncs[""] = function(var)



end]]

MLTypeFuncs["Scenery"] = function(var)

	local spr = Scenery(var.pos, var.path, var.layer or 0, var.anim or "", var.scale or Vec2(1, 1))

end

MLTypeFuncs["lua"] = function(var) --oh hi there

	try(loadstring(var.con))

end

MLTypeFuncs["luascript"] = function(var)

	try(function() include(var.path) end)

end

MLTypeFuncs["background"] = function(var)

	local bg

	try(function() bg = Image(var.path, Vec2(0, 0)) end)

	local s = Vec2(1, 1)

	if var.scale then

		s = var.scale

	end

	bg:SetScale(s)

	local d = tonumber(var.depth) or 1

	table.insert(background, {d, bg})

end

MLTypeFuncs["foreground"] = function(var)

	local bg

	try(function() bg = Image(var.path, Vec2(0, 0)) end)

	local s = Vec2(1, 1)

	if var.scale then

		s = var.scale

	end

	bg:SetScale(s)

	local d = tonumber(var.depth) or 1

	table.insert(foreground, {d, bg})

end

MLTypeFuncs["Solid"] = function(var)

	local ent = Entity()
	ent:SetPhys(PhysRect(ent, var.pos + (var.size / 2), 0, var.size.x, var.size.y))

end