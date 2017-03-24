DXGUIImage = DXGUIElement:subclass("DXGUIImage")

function DXGUIImage:init(metaName, text)
	self.super:init(metaName, "DXGUIImage")
	table.insert(DXGUIObjectTable, self)
end


--getters/setters
function DXGUIImage:setVisible(visible)
	self.visible = visible
	if visible then
		DXGUIElementRenderingTable[self.metaName] = self
	else
		DXGUIElementRenderingTable[self.metaName] = nil
	end
end
function DXGUIImage:isVisible()
	return self.visible
end


--other functions
function DXGUIImage:drawFrame()
	local element = self.element
	local position = self:getPosition()
	local size = self:getSize()
	local text = self.text
	local colour = self:getColour()
	local postgui = false
	local font = self.font 
	local fontSize = self.fontSize 
	local alignX = self.alignX
	local alignY = self.alignY
	
	dxDrawText(text, position.x, position.y, position.x+size.x, position.y+size.y, tocolor( 255, 255, 255, 255 ), fontSize, font, alignX, alignY) 
	
	self:triggerEvents()
end
