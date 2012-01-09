class.PhysBase() --only EXTEND

function PhysBase:__init(pos, mass)

	self.body = love.physics.newBody(World, pos.x, pos.y, mass)
	self.body:setInertia(mass / 10)

end


class.PhysCircle(PhysBase) --circle shape

function PhysCircle:__init(pos, mass, radius)

	PhysBase.__init(self, pos, mass)
	self.shape = love.physics.newCircleShape(0, 0, radius)
	self.debugdraw = true
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)

end

function PhysCircle:Draw()

	local g = love.graphics
	if self.debugdraw then
		local x, y = self.body:getX(), self.body:getY()
		g.setColor(255, 255, 255, 125)
		g.push()
		g.translate(x, y)
		g.rotate(self.body:getAngle())
		g.translate(-x, -y)
		g.circle("fill", x, y, self.shape:getRadius())
		g.pop()
	end

end


class.PhysRect(PhysBase) --rectangle shape

function PhysRect:__init(pos, mass, w, h)

	PhysBase.__init(self, pos, mass)
	self.shape = love.physics.newRectangleShape(self.body, 0, 0, w, h, 0)
	self.shape:setFriction(1)
	self.size = Vec2(w, h)
	self.debugdraw = true

end

function PhysRect:Draw()

	local g = love.graphics
	if self.debugdraw then
		g.setColor(255, 255, 255, 255)
    	g.push()
    	local x, y = self.body:getPosition()
    	local x1,y1, x2,y2, x3,y3, x4,y4 = self.shape:getBoundingBox()
    	g.translate(x, y)
    	g.rotate(self.body:getAngle())
    	g.translate(-x, -y)
    	love.graphics.rectangle("fill", x - self.size.x / 2, y - self.size.y / 2, self.size.x, self.size.y, 0)
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