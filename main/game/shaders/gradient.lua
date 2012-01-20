---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 1/17/12
-- Time: 9:12 PM
--

--Gradient Shader

local shd = Shader.Load("Gradient",
	[[
	extern number time;
	extern number time2;
	extern vec2 size;
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
    {
        number xc = pixel_coords.x;
        number yc = pixel_coords.y;
        number xr = xc / size[0];
        number yr = yc / size[1];
        number cs = (tan(time2) + 1.1) / 2;
        number sn = (cs * sin(time / 2) + 1) / 2; //0 to 1
        number gra = xr + (yr - xr) * sn;
        return vec4(gra, gra, gra, 1.0);
    }
]])

function shd:Update(dt)

	self:send("time", love.timer.getTime())
	self:send("time2", love.timer.getMicroTime())

end