---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 1/1/12
-- Time: 3:24 PM
--

function YesNoBox(t, yf, nf, ncb)

	if not goo then return end

	local box = goo.panel:new()
	box:setPos(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
	box:setSize(100, 35)
	box:setTitle(t)
	if ncb then box:showCloseButton(false) end

	local yb = goo.button:new(box)
	yb:setText("Yes")
	yb:sizeToText()
	yb:setPos(10, 15)
	yb.onClick = function()
		yf()
		box:removeFromParent()
	end

	local nb = goo.button:new(box)
	nb:setText("No")
	nb:sizeToText()
	nb:setPos(60, 15)
	nb.onClick = function()
		nf()
		box:removeFromParent()
	end

	return box

end
