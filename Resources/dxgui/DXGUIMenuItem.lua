DXGUIMenuItem = DXGUIElement:subclass("DXGUIMenuItem")

function DXGUIMenuItem:init(metaName, title, iconFilePath)
	self.super:init(metaName, "DXGUIMenuItem")
	table.insert(DXGUIObjectTable, self)
	self.active = false
	self.iconFilePath = iconFilePath --icon
	
	--text
	local label = DXGUILabel:new("DXGUILabel", "text")
	label:setPosition(self.position)
	label:setSize(self.size)
	label:setFontSize("auto") --TODO: infinite loop (fixed???)
	label:setParent(self)
	
	--Icon
	--TODO: icon
	
	addChildToClass(self, label)
end


--getters/setters
function DXGUIMenuItem:setVisible(visible)
	self.visible = visible
	if visible then
		DXGUIElementRenderingTable[self.metaName] = self
	else
		DXGUIElementRenderingTable[self.metaName] = nil
	end
end
function DXGUIMenuItem:isVisible()
	return self.visible
end

function DXGUIMenuItem:setTitle(title)
	self.title = title
end
function DXGUIMenuItem:getTitle()
	return self.title
end

function DXGUIMenuItem:setIconFilePath(iconFilePath)
	self.iconFilePath = iconFilePath
end
function DXGUIMenuItem:getIconFilePath()
	return self.iconFilePath
end


--other functions
function DXGUIMenuItem:drawFrame()
	local element = self.element
	local collapsed = self.collapsed
	local position = self:getPosition()
	local size = self:getSize()
	local colour = self:getColour()
	local postgui = false
	local titleBarHeight = self.titleBarHeight
	
	dxDrawBorderedRectangle(position.x, position.y, size.x, size.y, tocolor(0,0,0,200), colour, 1, postgui)	
	
	self:triggerEvents()
end

function DXGUIWindow:closeWindow() --not implemented
	
end

function DXGUIWindow:collapeWindow() --not implemented
	
end