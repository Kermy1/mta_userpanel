DXGUIWindow = DXGUIElement:subclass("DXGUIWindow")

function DXGUIWindow:init(metaName, title, iconFilePath)
	self.super:init(metaName, "DXGUIWindow")
	table.insert(DXGUIObjectTable, self)
	self.collapseAble = false
	self.closeAble = false
	self.collapsed = false
	self.closed = false
	self.iconFilePath = iconFilePath --window icon
	self.titleBarHeight = heightScale*30
	
	local label = DXGUILabel:new("DXGUILabel", "")
	label:setPosition(self.position)
	label:setSize(Vector2(self.size.x, titleBarHeight))
	label:setColour(Vector4(255,255,255,255))
	label:setFontSize("auto") --TODO: infinite loop (fixed???)
	label:setParent(self)
	addChildToClass(self, label)
	self.title = label
	
	local icon = DXGUIImage:new("DXGUIImage", "../images/icon.png")
	label:setPosition(self.position)
	label:setSize(self.size)
	icon:setParent(self)
	addChildToClass(self, icon)
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
	self.title:setText(title)
end
function DXGUIWindow:getTitle()
	return self.title:getText()
end

function DXGUIWindow:setIconFilePath(iconFilePath)
	self.iconFilePath = iconFilePath
end
function DXGUIWindow:getIconFilePath()
	return self.iconFilePath
end

function DXGUIWindow:isClosed()
	return self.closed
end

function DXGUIWindow:isCollapsed()
	return self.collapsed
end


--other functions
function DXGUIWindow:drawFrame()
	local element = self.element
	local collapsed = self.collapsed
	local position = self:getPosition()
	local size = self:getSize()
	local colour = self:getColour()
	local postgui = false
	local titleBarHeight = self.titleBarHeight
	
	--rounded corners?
	
	dxDrawBorderedRectangle(position.x, position.y, size.x, size.y, colour, tocolor(255,255,255,255), 1, postgui)	
	
	self:triggerEvents()
end

function DXGUIWindow:closeWindow() --not implemented
	
end

function DXGUIWindow:collapeWindow() --not implemented
	
end