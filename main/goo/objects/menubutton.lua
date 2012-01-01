-- menubutton
goo.menubutton = mclass('goo menubutton', goo.object)
function goo.menubutton:initialize( parent )
	super.initialize(self,parent)
	self.text = "menubutton"
	self.borderStyle = 'line'
	self.backgroundColor = {0,0,0,255}
	self.borderColor = {255,255,255,255}
	self.textColor = {255,255,255,255}
	self.spacing = 5
	self.border = true
	self.background = true
end
function goo.menubutton:draw()
	if self.background then
		self:setColor( self.backgroundColor )
		love.graphics.rectangle( 'fill', 0, 0, self.w, self.h )
	end
	if self.border then
		love.graphics.setLine( 1, 'rough' )
		self:setColor( self.borderColor )
		love.graphics.rectangle( 'line', 0, 0, self.w, self.h )
	end
	
	self:setColor( self.textColor )
	love.graphics.setFont( self.style.textFont )
	local fontW, fontH = self.style.textFont:getWidth(self.text or ''), self.style.textFont:getHeight()
	local ypos = ((self.h - fontH)/2)
	local xpos = ((self.w - fontW)/2)
	love.graphics.print( self.text, xpos, ypos )
end
function goo.menubutton:enterHover()
	self.backgroundColor = self.style.backgroundColorHover
	self.borderColor = self.style.borderColorHover
	self.textColor = self.style.textColorHover
end
function goo.menubutton:exitHover()
	self.backgroundColor = self.style.backgroundColor
	self.borderColor = self.style.borderColor
	self.textColor = self.style.textColor
end
function goo.menubutton:mousepressed(x,y,menubutton)
	if self.onClick then self:onClick(menubutton) end
	self:updateBounds( 'children', self.updateBounds )
end
function goo.menubutton:setText( text )
	self.text = text or ''
end
function goo.menubutton:sizeToText( padding )
	local padding = padding or 5
	local _font = self.style.textFont or love.graphics.getFont()
	self.w = _font:getWidth(self.text or '') + (padding*2)
	self.h = _font:getHeight()  + (padding*2)
	self:updateBounds()
end
goo.menubutton:getterSetter('border')
goo.menubutton:getterSetter('background')

return goo.menubutton