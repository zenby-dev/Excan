class.Entity(Ent)

function Entity:__init(phys)

	self.phys = phys
	
	Ent.__init(self)

end

function Entity:Update(dt)

	

end

function Entity:Draw()

	self.phys:Draw()

end

function Entity:applyForce(x, y)

	self.phys.body:applyForce(x, y)

end

function Entity:GetPos()

	return Vec2(self.phys.body:getPosition())

end

function Entity:GetRot()

	return self.phys.body:getAngle()

end

function PC(x, y, m, r) Entity(PhysCircle(Vec2(x, y), m, r)) end
function PR(x, y, m, w, h) Entity(PhysRect(Vec2(x, y), m, w, h)) end
