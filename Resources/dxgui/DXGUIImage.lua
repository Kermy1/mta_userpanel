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
	local position = self.position
	local size = self.size
	local text = self.text
	local postgui = false
	local font = self.font 
	local fontSize = self.fontSize 
	local alignX = self.alignX
	local alignY = self.alignY
	
	dxDrawText(text, position.x, position.y, position.x+size.x, position.y+size.y, tocolor( 255, 255, 255, 255 ), fontSize, font, alignX, alignY) 
	
	if isMouseInRec(position.x, position.y, size.x, size.y) then --hover
		triggerEvent("OnDXGUIMouseHover", element)
		if getKeyState("mouse1") then --click
			triggerEvent("OnDXGUIMouseClickBounce", element)
		end
	end
end
