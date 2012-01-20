---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 1/17/12
-- Time: 9:12 PM
--

--Gradient Shader

Shader.Load("BlurX",
	[[
	extern number size;
	extern number sd;

	number gaussian(number x)
	{
		return exp(-1 * (pow(x, 2) / (2 * pow(sd, 2)))) * inversesqrt(2 * 3.14159 * pow(sd, 2));
	}

	vec4 horizontal(Image texture, vec2 tc)
	{
		vec4 sum = vec4(0.0);

		sum += texture2D(texture, vec2(tc.x - 4.0*size, tc.y)) * gaussian(-4);
		sum += texture2D(texture, vec2(tc.x - 3.0*size, tc.y)) * gaussian(-3);
		sum += texture2D(texture, vec2(tc.x - 2.0*size, tc.y)) * gaussian(-2);
		sum += texture2D(texture, vec2(tc.x - size, tc.y)) * gaussian(-1);
		sum += texture2D(texture, vec2(tc.x, tc.y)) * gaussian(0);
		sum += texture2D(texture, vec2(tc.x + size, tc.y)) * gaussian(1);
		sum += texture2D(texture, vec2(tc.x + 2.0*size, tc.y)) * gaussian(2);
		sum += texture2D(texture, vec2(tc.x + 3.0*size, tc.y)) * gaussian(3);
		sum += texture2D(texture, vec2(tc.x + 4.0*size, tc.y)) * gaussian(4);
        return sum;
	}

    vec4 effect(vec4 gcol, Image texture, vec2 tc, vec2 pc)
    {
		vec4 sum = horizontal(texture, tc);
        return sum;
    }
]])

Shader.Load("BlurY",
	[[
	extern number size;
	extern number sd;

	number gaussian(number x)
	{
		return exp(-1 * (pow(x, 2) / (2 * pow(sd, 2)))) * inversesqrt(2 * 3.14159 * pow(sd, 2));
	}

	vec4 vertical(Image texture, vec2 tc)
	{
		vec4 sum = vec4(0.0);

		sum += texture2D(texture, vec2(tc.x, tc.y - 4.0*size)) * gaussian(-4);
		sum += texture2D(texture, vec2(tc.x, tc.y - 3.0*size)) * gaussian(-3);
		sum += texture2D(texture, vec2(tc.x, tc.y - 2.0*size)) * gaussian(-2);
		sum += texture2D(texture, vec2(tc.x, tc.y - size)) * gaussian(-1);
		sum += texture2D(texture, vec2(tc.x, tc.y)) * gaussian(0);
		sum += texture2D(texture, vec2(tc.x, tc.y + size)) * gaussian(1);
		sum += texture2D(texture, vec2(tc.x, tc.y + 2.0*size)) * gaussian(2);
		sum += texture2D(texture, vec2(tc.x, tc.y + 3.0*size)) * gaussian(3);
		sum += texture2D(texture, vec2(tc.x, tc.y + 4.0*size)) * gaussian(4);
        return sum;
	}

    vec4 effect(vec4 gcol, Image texture, vec2 tc, vec2 pc)
    {
		vec4 sum = vertical(texture, tc);
        return sum;
    }
]])

Shader.NewCR("Blur",
function(df, size, sd) --larger sizes are sharper
	local g = love.graphics
	
	--g.setColor(255, 255, 255, 255 / 2)
	--df()
	--g.setColor(255, 255, 255, 255)
	
	local canv = g.newCanvas()
	g.setRenderTarget(canv)
	Shader.Set("BlurX", {"size", 1 / size}, {"sd", sd})
	--g.setBlendMode("premultiplied")
	df()
	--g.setBlendMode("alpha")
	Shader.Set()
	g.setRenderTarget()

	Shader.Set("BlurY", {"size", 1 / size}, {"sd", sd})
	g.setBlendMode("additive")
	g.draw(canv, CameraPos.x, CameraPos.y)
	g.setBlendMode("alpha")
	Shader.Set()

end
)
--[[function shd:Update(dt)



end]]