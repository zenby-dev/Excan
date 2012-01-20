---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 1/17/12
-- Time: 9:12 PM
--

--Gradient Shader

local shd = Shader.Load("WARBLE",
	[[
	extern number time;
    vec4 effect(vec4 gcolor, Image texture, vec2 tc, vec2 pc)
    {
		number xc = pc.x + time * 20;
		number yc = pc.y;
		//((sin(time) + 1) / 2)
		//number gra = (((sin(((xc / 5) + ((sin(time) + 1) / 2)) / 2) + 1) / 2) + ((cos(yc / 5) + 1) / 2)) / 2;
		number gra = (((sin(xc / 5) + 1) / 2) + ((cos(yc / 5) + 1) / 2)) / 2;
		vec4 tex = texture2D(texture, tc);
		return vec4((tex.r + gra) / 2, (tex.g + gra) / 2, (tex.b + gra) / 2, tex.a);
    }
]])

function shd:Update(dt)

	self:send("time", love.timer.getMicroTime())

end