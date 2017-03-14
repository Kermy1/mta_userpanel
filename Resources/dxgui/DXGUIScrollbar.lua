DXGUIScrollbar = DXGUIElement:subclass("DXGUIScrollbar")

function DXGUIScrollbar:init(metaName, text)
	self.super:init(metaName, "DXGUIScrollbar")
end


--getters/setters
function DXGUIScrollbar:setVisible(visible)
	self.visible = visible
	if visible then
		DXGUIElementRenderingTable[self.metaName] = self
	else
		DXGUIElementRenderingTable[self.metaName] = nil
	end
end
function DXGUIScrollbar:isVisible()
	return self.visible
end


--other functions
function DXGUIScrollbar:drawFrame()
	local position = self.position
	local size = self.size
	local text = self.text
	local postgui = false
	local font = self.font 
	local fontSize = self.fontSize 
	local alignX = self.alignX
	local alignY = self.alignY
	
	dxDrawText(text, position.x, position.y, position.x+size.x, position.y+size.y, tocolor( 255, 255, 255, 255 ), fontSize, font, alignX, alignY) 
	
end
