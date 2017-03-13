DXGUIButton = DXGUIElement:subclass("DXGUIButton")

function DXGUIButton:init(metaName, text)
	self.super:init(metaName)
	self.text = text
	self.fontSize = 1
	self.clip = true
	self.wordBreak = false
	self.font = "default"
	self.alignX = "center"
	self.alignY = "center"
end


--getters/setters
function DXGUIButton:setVisible(visible)
	self.visible = visible
	if visible then
		DXGUIElementRenderingTable[self.metaName] = self
	else
		DXGUIElementRenderingTable[self.metaName] = nil
	end
end
function DXGUIButton:isVisible()
	return self.visible
end

function DXGUIButton:setText(text)
	self.text = text
end
function DXGUIButton:getText()
	return self.text
end


--other functions
function DXGUILabel:drawFrame()
	local position = self.position
	local size = self.size
	local text = self.text
	local postgui = false
	local font = self.font 
	local fontSize = self.fontSize 
	local alignX = self.alignX
	local alignY = self.alignY
	
	DxDrawBorderedRectangle(position.x, position.y, size.x, size.y, tocolor(0,0,0,200), colour, 1, postgui)
	dxDrawText(text, position.x, position.y, position.x+size.x, position.y+size.y, tocolor( 255, 255, 255, 255 ), fontSize, font, alignX, alignY) 
end