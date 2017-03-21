DXGUIDropdown = DXGUIElement:subclass("DXGUIDropdown")

function DXGUIDropdown:init(metaName, text)
	self.super:init(metaName, "DXGUIDropdown")
	self.text = text
	self.fontSize = 1
	self.clip = true
	self.wordBreak = false
	self.font = "default"
	self.alignX = "center"
	self.alignY = "center"
end


--getters/setters
function DXGUIDropdown:setVisible(visible)
	self.visible = visible
	if visible then
		DXGUIElementRenderingTable[self.metaName] = self
	else
		DXGUIElementRenderingTable[self.metaName] = nil
	end
end
function DXGUIDropdown:isVisible()
	return self.visible
end




--other functions
function DXGUIDropdown:drawFrame()
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
	
end
