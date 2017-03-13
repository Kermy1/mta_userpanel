--out of oop context function--
--all GUI objects in this table will be rendered on the screen (works recursively on the children)--
DXGUIElementRenderingTable = {}
function drawDXGUIElements(DXGUIElementsTable)
	for key,value in pairs(DXGUIElementsTable) do
		outputDebugString(value:getMetaName())
		value:drawFrame()
		drawDXGUIElements(value:getChildren())
	end
end
function startDrawingGUI()
	drawDXGUIElements(DXGUIElementRenderingTable)
end
addEventHandler("onClientRender", getRootElement(), startDrawingGUI)

function addChildToClass(parent, child)
	parent:addChild(child)
end



--DXGUIElement superclass
DXGUIElement = newclass("DXGUIElement")

function DXGUIElement:init(metaName)
	self.metaName = metaName
	self.position = Vector3(0,0,0)
	self.size = Vector2(0,0)
	self.visible = false
	self.colour = tocolor(255,255,255,255)
	self.parent = nil
	self.children = {}
end


--getters/setters
function DXGUIElement:setMetaName(metaName)
	self.metaName = metaName
end
function DXGUIElement:getMetaName()
	return self.metaName
end

function DXGUIElement:setPosition(position)
	self.position = position
end
function DXGUIElement:getPosition()
	return self.position
end

function DXGUIElement:setSize(size)
	self.size = size
end
function DXGUIElement:getSize()
	return self.size
end

function DXGUIElement:setColour(r,g,b,a)
	self.colour = tocolor(r,g,b,a)
end
function DXGUIElement:getColour()
	return self.colour
end

function DXGUIElement:setParent(parent)
	self.parent = parent
	parent:addChild(self)
end
function DXGUIElement:getParent()
	return self.parent
end

function DXGUIElement:addChild(DXGUIElement)
	table.insert(self.children, DXGUIElement)
end

function DXGUIElement:getChildren()
	return self.children
end


--other functions
function DXGUIElement:setToFront()
	self.position = Vector3(self.position.x, self.position.y, 999999999999999)
end
function DXGUIElement:setToBack()
	self.position = Vector3(self.position.x, self.position.y, -999999999999999)
end

--events
addEvent("OnDXGUIMouseHover")
addEvent("OnDXGUIMouseClick")
addEvent("OnDXGUIElementStartRendering")
addEvent("OnDXGUIElementRendering")
addEvent("OnDXGUIElementStoppedRendering")
addEvent("OnDXGUIMouseHover")




