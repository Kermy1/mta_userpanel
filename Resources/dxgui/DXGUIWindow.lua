DXGUIWindow = DXGUIElement:subclass("DXGUIWindow")

function DXGUIWindow:init(metaName, title, iconFilePath)
	self.super:init(metaName)
	self.collapseAble = false
	self.closeAble = false
	self.collapsed = false
	self.closed = false
	self.iconFilePath = iconFilePath
	self.titleBarHeight = heightScale*30
	local label = DXGUILabel:new("DXGUILabel", "text")
	label:setPosition(self.position)
	label:setSize(self.size)
	--label:setFontSize("auto") --TODO: infinite loop
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

function DXGUIWindow:setCollapseAble(collapseAble)
	self.collapseAble = collapseAble
end
function DXGUIWindow:getCollapseAble()
	return self.collapseAble
end

function DXGUIWindow:setCloseAble(closeAble)
	self.closeAble = closeAble
end
function DXGUIWindow:getCloseAble()
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

function DXGUIWindow:isClosed()
	return self.closed
end

function DXGUIWindow:isCollapsed()
	return self.collapsed
end


--other functions
function DXGUIWindow:drawFrame()
	local collapsed = self.collapsed
	local position = self.position
	local size = self.size
	local colour = self.colour
	local postgui = false
	local titleBarHeight = self.titleBarHeight
	
	DxDrawBorderedRectangle(position.x, position.y, size.x, size.y, tocolor(0,0,0,200), colour, 1, postgui)	
end

function DXGUIWindow:closeWindow()
	
end

function DXGUIWindow:collapeWindow()
	
end