---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 1/8/12
-- Time: 3:18 PM
--

function StartNewGame()

	SetState("explore")
	Map()

	DYNTEST = LoadSprite("game/sprites/player.lua")
	DYNTEST:SetAnim("walk")
	DYNTEST:SetScale(Vec2(10, 10))

end

hook.Add("Draw", "degaagas", function()

	DYNTEST:Draw()

end, "explore")

hook.Add("Update", "degaagas", function(dt)

	DYNTEST:Update(dt)

end, "explore")