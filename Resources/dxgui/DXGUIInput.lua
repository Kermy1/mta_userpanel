DXGUIInput = DXGUIElement:subclass("DXGUIInput")

function DXGUIInput:init(metaName, text)
	self.super:init(metaName, "DXGUIInput")
	table.insert(DXGUIObjectTable, self)
	self.text = text
	self.fontSize = 1
	self.clip = true
	self.wordBreak = false
	self.font = "default"
	self.alignX = "left"
	self.alignY = "center"
end


--getters/setters
function DXGUIInput:setVisible(visible)
	self.visible = visible
	if visible then
		DXGUIElementRenderingTable[self.metaName] = self
	else
		DXGUIElementRenderingTable[self.metaName] = nil
	end
end
function DXGUIInput:isVisible()
	return self.visible
end

function DXGUIInput:setText(text)
	self.text = text
end
function DXGUIInput:getText()
	return self.text
end



--other functions
function DXGUIInput:drawFrame()
	local element = self.element
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
