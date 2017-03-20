DXGUIWindow = DXGUIElement:subclass("DXGUIWindow")

function DXGUIWindow:init(metaName, title, iconFilePath)
	self.super:init(metaName, "DXGUIWindow")
	table.insert(DXGUIObjectTable, self)
	self.collapseAble = false
	self.closeAble = false
	self.collapsed = false
	self.closed = false
	self.iconFilePath = iconFilePath --window logo
	self.titleBarHeight = heightScale*30
	local label = DXGUILabel:new("DXGUILabel", "text")
	label:setPosition(self.position)
	label:setSize(self.size)
	label:setFontSize("auto") --TODO: infinite loop (fixed???)
	label:setParent(self)
	addChildToClass(self, label)
end


--getters/setters
function DXGUIWindow:setVisible(visible)
	self.visible = visible
	if visible then
		DXGUIElementRenderingTable[self.metaName] = self
	else
		DXGUIElementRenderingTable[self.metaName] = nil
	end
end
function DXGUIWindow:isVisible()
	return self.visible
end

function DXGUIWindow:setCollapseAble(collapseAble) --not implemented
	self.collapseAble = collapseAble
end
function DXGUIWindow:getCollapseAble() --not implemented
	return self.collapseAble
end

function DXGUIWindow:setCloseAble(closeAble) --not implemented
	self.closeAble = closeAble
end
function DXGUIWindow:getCloseAble() --not implemented
	return self.closeAble
end

function DXGUIWindow:setTitle(title)
	self.title = title
end
function DXGUIWindow:getTitle()
	return self.title
end

function DXGUIWindow:setIconFilePath(iconFilePath)
	self.iconFilePath = iconFilePath
end
function DXGUIWindow:getIconFilePath()
	return self.iconFilePath
end

function DXGUIWindow:isClosed() --not implemented
	return self.closed
end

function DXGUIWindow:isCollapsed() --not implemented
	return self.collapsed
end


--other functions
function DXGUIWindow:drawFrame()
	local element = self.element
	local collapsed = self.collapsed
	local position = self:getPosition()
	local size = self:getSize()
	local colour = self.colour
	local postgui = false
	local titleBarHeight = self.titleBarHeight
	
	dxDrawBorderedRectangle(position.x, position.y, size.x, size.y, tocolor(0,0,0,200), colour, 1, postgui)	
	
	if isMouseInRec(position.x, position.y, size.x, size.y) then --hover
		triggerEvent("OnDXGUIMouseHover", element)
		if getKeyState("mouse1") then --click
			triggerEvent("OnDXGUIMouseClickBounce", element)
		end
	end
end

function DXGUIWindow:closeWindow() --not implemented
	
end

function DXGUIWindow:collapeWindow() --not implemented
	
end