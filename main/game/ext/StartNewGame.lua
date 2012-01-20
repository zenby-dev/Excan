---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 1/8/12
-- Time: 3:18 PM
--

function StartNewGame()

	SetState("explore")
	Map("resources/maps/testmap.lua", "explore")

	--[[DYNTEST = LoadSprite("resources/sprites/player.lua")
	DYNTEST:SetAnim("walk")
	DYNTEST:SetScale(Vec2(10, 10))]]

end

local function DrawMain()

	local g = love.graphics --wheee

	g.push()

	g.translate(-CameraPos.x, -CameraPos.y) --should be with all world elements

	g.setColor(255, 255, 255, 255)

	if #background > 0 then

		table.sort(background, function(a, b)

			return a[1] > b[1]

		end)

		for k, v in pairs(background) do

			g.push()

			--g.translate(-CameraPos.x, -CameraPos.y)

			g.scale(1 / v[1], 1 / v[1])

			local ms = 1 / v[1] --1 / 100 = 0.01, 1 / 1 = 1

			g.translate(CameraPos.x * (1 - ms), CameraPos.y * (1 - ms)) --approach 1 from 0 as depth increases

			v[2]:Draw()

			g.pop()

		end

	end --draw a background yes maybe?

	for k, v in pairs(ents) do

		if v.layer and v.layer == -2 then v:Draw() end

	end

	for k, v in pairs(ents) do

		if v.layer and v.layer == -1 then v:Draw() end

	end

	for k, v in pairs(ents) do

		if v.layer and v.layer == (nil or 0) then v:Draw() end

	end

	for k, v in pairs(ents) do

		if v.layer and v.layer == 1 then v:Draw() end

	end

	for k, v in pairs(ents) do

		if v.layer and v.layer == 2 then v:Draw() end

	end

	if #foreground > 0 then

		table.sort(foreground, function(a, b)

			return a[1] > b[1]

		end)

		for k, v in pairs(foreground) do

			g.push()

			--g.translate(-CameraPos.x, -CameraPos.y)

			g.scale(1 / v[1], 1 / v[1])

			local ms = 1 / v[1] --1 / 100 = 0.01, 1 / 1 = 1

			g.translate(CameraPos.x * (1 - ms), CameraPos.y * (1 - ms)) --approach 1 from 0 as depth increases

			v[2]:Draw()

			g.pop()

		end

	end

	g.pop()

	g.print("FPS: "..math.floor(1 / love.timer.getDelta()), 5, 5)

end

hook.Add("Draw", "DrawMain", DrawMain, "explore")

hook.Add("Update", "UpdateMain", function(dt)

	Shader.Update(dt)

	for k, v in pairs(ents) do

		v:Update(dt)

	end

	local kd = love.keyboard.isDown
	local speed = 300
	if kd("w") then CameraPos = CameraPos + Vec2(0, -1) * dt * speed end
	if kd("a") then CameraPos = CameraPos + Vec2(-1, 0) * dt * speed end
	if kd("s") then CameraPos = CameraPos + Vec2(0, 1) * dt * speed end
	if kd("d") then CameraPos = CameraPos + Vec2(1, 0) * dt * speed end

	--Update stuff

	--if player then love.graphics.setCaption(player:CurrentRegion().name or "None") end

	if CameraFocus then

		local vp = CameraFocus:GetPos() + Vec2(-love.graphics.getWidth() / 2, -love.graphics.getHeight() / 2)

		--[[if #background > 0 then

			vp = Vec2(math.Clamp(vp.x, 0, (background[1][2].i:getWidth() * background[1][2].scale.x) - sw), math.Clamp(vp.y, 0, (background[1][2].i:getHeight() * background[1][2].scale.y) - sh))

		end]]

		CameraPos = vp--CameraPos + (vp - CameraPos) * dt * 2

	end

end, "explore")