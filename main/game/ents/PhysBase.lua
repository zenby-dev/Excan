class.PhysBase() --only EXTEND

TPSF = 0.03125 --physics scale factor
FPSF = 32 --physics scale factor

function PhysBase:__init(pos, mass)

	self.body = love.physics.newBody(World, pos.x * TPSF, pos.y * TPSF, mass ~= 0 and "dynamic" or "static")
	self.body:setMassData(0, 0, mass, mass / 10)
	self.body:setSleepingAllowed(false) --MANDATORY CAFFEINE INJECTIONS EVERY HOUR
	--self.body:setInertia(mass / 10)

end


class.PhysCircle(PhysBase) --circle shape

function PhysCircle:__init(par, pos, mass, radius)

	PhysBase.__init(self, pos, mass)
	self.shape = love.physics.newCircleShape(0, 0, radius * TPSF)
	self.debugdraw = true
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(par.__entindex)

end

function PhysCircle:Draw()

	local g = love.graphics
	if self.debugdraw then
		local x, y = self.body:getX() * PSF, self.body:getY() * PSF
		g.setColor(255, 255, 255, 125)
		g.push()
		g.translate(x, y)
		g.rotate(self.body:getAngle())
		g.translate(-x, -y)
		g.circle("fill", x, y, self.shape:getRadius() * PSF)
		g.setColor(255, 255, 255, 255)
		g.pop()
	end

end


class.PhysRect(PhysBase) --rectangle shape

function PhysRect:__init(par, pos, mass, w, h) --divide size by PSF. 32 = 1.

	PhysBase.__init(self, pos, mass)
	self.shape = love.physics.newRectangleShape(0, 0, w * TPSF, h * TPSF, 0)
	self.size = Vec2(w * TPSF, h * TPSF)
	self.debugdraw = true
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(par.__entindex)

	self.__type = "PhysRect"

end

function PhysRect:Draw()

	local g = love.graphics
	if self.debugdraw then
		g.setColor(255, 255, 255, 255)
    	g.push()
    	local x, y = self.body:getPosition()
		x, y = x * FPSF, y * FPSF
    	local x1,y1, x2,y2, x3,y3, x4,y4 = self.shape:getPoints()
    	g.translate(x, y)
    	g.rotate(self.body:getAngle())
    	g.translate(-x, -y)
		local size = self.size * FPSF
		local points = {self.shape:getPoints()}
		--table.insert(points, points[1])
		--table.insert(points, points[2])
		love.graphics.setPoint(5, "smooth")
		for k, v in pairs(points) do points[k] = (v * FPSF) + (k % 2 == 1 and x or y) end
		for i = 1, #points, 2 do love.graphics.point(points[i], points[i + 1]) end
    	--love.graphics.line(points)
		--[[love.graphics.rectangle("line", x - size.x / 2, y - size.y / 2, size.x, size.y)
		love.graphics.line(x, y, x, y + size.y)
		love.graphics.line(x, y, x, y - size.y)
		love.graphics.line(x, y, x + size.x, y)
		love.graphics.line(x, y, x - size.x, y)
		love.graphics.line(x + 32, y - 16, x + 32, y + 16)]]
		--love.graphics.point(x, y)
    	g.pop()
    	--g.print("I AM BOX", self.body:getX(), self.body:getY())
	end

end


function CreatePhysWorld(gv, setw)

	if not Worlds then Worlds = {} end
	Worlds[GetState()] = love.physics.newWorld(gv.x, gv.y)
	if setw then World = Worlds[GetState()] end
	return Worlds[GetState()]

end