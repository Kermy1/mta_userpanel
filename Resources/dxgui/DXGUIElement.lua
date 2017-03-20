--out of oop context function--
--all GUI objects in this table will be rendered on the screen (works recursively on the children)--
DXGUIObjectTable = {}
DXGUIElementRenderingTable = {}
function drawDXGUIElements(DXGUIElementsTable)
	for key,value in pairs(DXGUIElementsTable) do
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

--"OnDXGUIMouseClickBounce" triggers every frame the user holds down the lmouse button while on the GUI element
clickBounceTable = {} --table to support multiple GUI elements to be clicked at the same time (not sure if overkill)
bounceTimerTable = {} --table to support multiple GUI elements to be clicked at the same time (not sure if overkill)
function clickBounceRemover()
	if clickBounceTable[getElementID(source)] == nil then --is element already clicked in the last quarter second
		clickBounceTable[getElementID(source)] = source
		local bounceTimer = setTimer(removeFromBounceTable, 250, 1, source)
		bounceTimerTable[getElementID(source)] = bounceTimer
		triggerEvent("OnDXGUIMouseClick", source)
	else
		resetTimer(bounceTimerTable[getElementID(source)])
	end
end
addEventHandler("OnDXGUIMouseClickBounce", getRootElement(), clickBounceRemover)
function removeFromBounceTable(element)
	clickBounceTable[getElementID(element)] = nil
end

function getGUIObjectFromElement(element)
	return DXGUIObjectTable[getElementID(element)]
end


--DXGUIElement superclass
DXGUIElement = newclass("DXGUIElement")

function DXGUIElement:init(metaName, DXGUIElementType)
	self.metaName = metaName
	self.position = Vector3(0,0,0) --relative to parent
	self.size = Vector2(0,0) --relative to parent
	self.visible = false
	self.colour = tocolor(255,255,255,255)
	self.font = "default"
	self.parent = nil
	self.children = {}
	self.element = createElement(DXGUIElementType, metaName) -- for event purposes
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
	if self.parent != nil then --if has parent
		local parentPos = self.parent:getPosition()
		return vector3(parentPos.x+self.position.x, parentPos.y+self.position.y, parentPos.z+self.position.z)
	else
		return self.position
	end
end

function DXGUIElement:setSize(size)
	local ratioX = self.size.x/size.x
	local ratioY = self.size.y/size.y
	self.size = size
	if #self.children > 0 then --if has children
		for child in self.children do
			local childSize = child:getSize
			child:setSize(Vector2(childSize.x*ratioX, childSize.y*ratioY))
		end
	end
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
addEvent("OnDXGUIFocus") --input class
addEvent("OnDXGUIMouseClick") --after bounce remove
addEvent("OnDXGUIMouseClickBounce") --before bounce remove
addEvent("OnDXGUIElementStartRendering")
--addEvent("OnDXGUIElementRendering")
addEvent("OnDXGUIElementStoppedRendering")




