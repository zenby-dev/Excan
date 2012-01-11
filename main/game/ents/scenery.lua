class.Scenery(Ent)

function Scenery:__init(pos, path, und, anim, scale)

	self.pos = pos
	self.sprite = LoadSprite(path)
	self.layer = und
	self.anim = anim or ""
	if scale then self.sprite:SetScale(scale) end
	
	Ent.__init(self)

end

function Scenery:Update(dt)

	self.sprite:SetPos(self.pos)
	if self.sprite.anim ~= self.anim then self.sprite:SetAnim(self.anim) end
	self.sprite:Update(dt)

end

function Scenery:Draw()

	self.sprite:Draw()

end