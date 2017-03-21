--out of oop context--
function handlePlayerCharacterInput(character)
	local object = getGUIObjectFromElement(source)
	if object:isFocused() then
		object:setValue(object:getValue()..character)
	end
end
function handlePlayerBackSpaceInput(button, press)
	if press and button == "backspace" then
		local object = getGUIObjectFromElement(source)
		object:setValue(string.sub(object:getValue(), 0, -1))
	end
end

DXGUIInput = DXGUIElement:subclass("DXGUIInput")

function DXGUIInput:init(metaName, value)
	self.super:init(metaName, "DXGUIInput")
	table.insert(DXGUIObjectTable, self)
	self.value = value
	self.fontSize = 1
	self.clip = true
	self.wordBreak = false
	self.focused = false
	self.font = "default"
	self.alignX = "left"
	self.alignY = "center"
	addEventHandler("onClientCharacter", self.element, handlePlayerCharacterInput)
	addEventHandler("onClientKey", self.element, handlePlayerBackSpaceInput)
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

function DXGUIInput:setValue(value)
	self.value = value
end
function DXGUIInput:getValue()
	return self.value
end

function DXGUIInput:setFocused(focused)
	self.focused = focused
end
function DXGUIInput:isFocused()
	return self.focused
end



--other functions
function DXGUIInput:drawFrame()
	local element = self.element
	local position = self:getPosition()
	local size = self:getSize()
	local value = self.value
	local colour = self:getColour()
	local postgui = false
	local font = self.font 
	local fontSize = self.fontSize 
	local alignX = self.alignX
	local alignY = self.alignY
	
	dxDrawText(value, position.x, position.y, position.x+size.x, position.y+size.y, tocolor( 255, 255, 255, 255 ), fontSize, font, alignX, alignY) 
	
	if isMouseInRec(position.x, position.y, size.x, size.y) then --hover
		triggerEvent("OnDXGUIMouseHover", element)
		if getKeyState("mouse1") then --click
			triggerEvent("OnDXGUIMouseClickBounce", element)
		end
	end
end
