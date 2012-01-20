---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 1/18/12
-- Time: 6:07 PM
--

Shader = {}
Shader.shaders = {}
Shader.CRs = {}
Shader.enabled = (SETTINGS.ENABLESHADERS or true)

function Shader.Load(name, sh)

	local shader = love.graphics.newPixelEffect(sh)
	Shader.shaders[name] = {shader = shader} --shader shader shader shader shader shader shader shader shader
	local shd = Shader.Get(name)
	function shd.send(self, ...)

		self.shader:send(...)

	end

	return shd

end

function Shader.Enable(b)

	Shader.enabled = b

end

function Shader.Send(name, ...)

	if not Shader.enabled then return end

	local shd = Shader.Get(name)

	if shd == nil then return end

	shd:send(...)

end

function Shader.Set(name, ...)

	if name == nil then love.graphics.setPixelEffect() return end

	if not Shader.enabled then return end

	local shd = Shader.Get(name)

	if shd == nil then return end

	local sends = {...}

	for k, v in pairs(sends) do

		shd:send(unpack(v))

	end

	love.graphics.setPixelEffect(shd.shader)

end

function Shader.Update(dt)

	if not Shader.enabled then return end

	for k, v in pairs(Shader.shaders) do

		if v.Update then v:Update(dt) end

	end

end

function Shader.Get(name)

	return Shader.shaders[name]

end

function Shader.NewCR(name, f)

	Shader.CRs[name] = f

end

function Shader.ComplexRender(name, df, ...)

	if not Shader.enabled or (Shader.enabled and not Shader.CRs[name]) then df() return end

	Shader.CRs[name](df, ...) --pass on extra arguments

end

requiredir("/game/shaders")