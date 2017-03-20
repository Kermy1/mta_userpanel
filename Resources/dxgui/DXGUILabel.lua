DXGUILabel = DXGUIElement:subclass("DXGUILabel")

function DXGUILabel:init(metaName, text)
	self.super:init(metaName, "DXGUILabel")
	table.insert(DXGUIObjectTable, self)
	self.text = text
	self.fontSize = 1
	self.clip = true
	self.wordBreak = false
	self.font = "default"
	self.alignX = "center"
	self.alignY = "center"
end


--getters/setters
function DXGUILabel:setVisible(visible)
	self.visible = visible
	if visible then
		DXGUIElementRenderingTable[self.metaName] = self
	else
		DXGUIElementRenderingTable[self.metaName] = nil
	end
end
function DXGUILabel:isVisible()
	return self.visible
end

function DXGUILabel:setText(text)
	self.text = text
end
function DXGUILabel:getText()
	return self.text
end

function DXGUILabel:setClip(clip)
	self.clip = clip
end

function DXGUILabel:setWordBreak(wordBreak)
	self.wordBreak = wordBreak
end

function DXGUILabel:setFont(font)
	self.font = font
end

function DXGUILabel:setFontSize(fontSize)
	if fontSize == "auto" then
		self.fontSize = getFontSize(self.text, self.size.x, self.size.y)
	else
		self.fontSize = fontSize
	end
end



--other functions
function DXGUILabel:drawFrame()
	local element = self.element
	local position = self.position
	local size = self.size
	local text = self.text
	local postgui = false
	local font = self.font 
	local fontSize = self.fontSize 
	local alignX = self.alignX
	local alignY = self.alignY
	
	outputDebugString(size)
	dxDrawText(text, position.x, position.y, position.x+size.x, position.y+size.y, tocolor(255, 255, 255, 255), fontSize, font, alignX, alignY) 
	dxDrawText('text', position.x, position.y, position.x+size.x, position.y+size.y, tocolor(255, 255, 255, 255), 5, "default", "center", "center") 
	
	if isMouseInRec(position.x, position.y, size.x, size.y) then --hover
		triggerEvent("OnDXGUIMouseHover", element)
		if getKeyState("mouse1") then --click
			triggerEvent("OnDXGUIMouseClickBounce", element)
		end
	end
end
