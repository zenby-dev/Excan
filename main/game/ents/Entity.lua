class.Entity(Ent)

function Entity:__init()
	
	Ent.__init(self)

	self.__type = "Entity"

end

function Entity:SetPhys(phys)

	self.phys = phys

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

function PC(x, y, m, r)

	local ent = Entity()
	ent:SetPhys(PhysCircle(ent, Vec2(x, y), m, r))
	return ent

end

function PR(x, y, m, w, h)

	local ent = Entity()
	ent:SetPhys(PhysRect(ent, Vec2(x, y), m, w, h))
	return ent

end
