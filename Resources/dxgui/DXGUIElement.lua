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

function animateDXGUIElement()
	GUIObject = getGUIObjectFromElement(source)
	local pos = GUIObject:getPosition()
	local size = GUIObject:getSize()
	local colour = GUIObject:getColourVector()
	local animFunction = GUIObject:getAnimFunction()
	local animPos = GUIObject:getAnimPosition()
	local animSize = GUIObject:getAnimSize()
	local animColour = GUIObject:getAnimColour()
	local startTime = GUIObject:getAnimStartTime()
	local elapseTime = GUIObject:getAnimElapseTime()
	local animProgress = (getTickCount()-startTime)/elapseTime
	
	--change position
	local x,y,z = interpolateBetween(pos.x, pos.y, pos.z, animePos.x, animePos.y, animePos.z, animProgress, animFunction)
	GUIObject:setPosition(Vector3(x, y, z))
	
	--change size
	local x,y,_ = interpolateBetween(size.x, size.y, 0, animSize.x, animSize.y, 0, animProgress, animFunction)
	GUIObject:setSize(Vector2(x, y))
	
	--change colour
	local x,y,z = interpolateBetween(colour.x, colour.y, colour.z, animColour.x, animColour.y, animColour.z, animProgress, animFunction)
	local w,_,_ = interpolateBetween(colour.w, 0, 0, animColour.w, 0, 0, animProgress, animFunction)
	GUIObject:setColour(Vector4(x, y, z, w))
	
	if (pos:compare(animePos) and size:compare(animeSize) and colour:compare(animColour)) or getTickCount() >= startTime+elapseTime then --animation finished
		GUIObject:stopAnimation()
	end
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
	self.animPosition = Vector3(0,0,0) --position the animation will go to
	self.size = Vector2(0,0) --relative to parent
	self.animSize = Vector2(0,0) --size the animation will go to
	self.visible = false
	self.colour = Vector4(0,0,0,0)
	self.animColour = Vector4(0,0,0,0)
	self.animElapseTime = 0 --ms
	self.animStartTime = 0 --ms
	self.animFunction = "Linear"
	self.font = "default"
	self.parent = nil
	self.mouseHover = false
	self.animation = false
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

function DXGUIElement:setColour(colour)
	self.colour = colour
end
function DXGUIElement:getColour()
	local c = self.colour
	return tocolor(c.x,c.y,c.z,c.w)
end
function DXGUIElement:getColourVector()
	return self.colour
end

function DXGUIElement:setParent(parent)
	self.parent = parent
end
function DXGUIElement:getParent()
	return self.parent
end

function DXGUIElement:getMouseHover()
	return self.mouseHover
end
function DXGUIElement:setMouseHover(bool)
	self.mouseHover = bool
end

function DXGUIElement:getAnimSize() --for animation purposes
	return self.animSize
end
function DXGUIElement:getAnimPosition() --for animation purposes
	return self.animPosition
end
function DXGUIElement:getAnimColour() --for animation purposes
	return self.animColour
end
function DXGUIElement:getAnimElapseTime() --for animation purposes
	return self.animElapseTime
end
function DXGUIElement:getAnimStartTime() --for animation purposes
	return self.animStartTime
end
function DXGUIElement:getAnimFunction() --for animation purposes
	return self.animFunction
end

function DXGUIElement:addChild(DXGUIElement)
	table.insert(self.children, DXGUIElement)
end

function DXGUIElement:getChildren()
	return self.children
end

function DXGUIElementIsInAnimation()
	return self.animation
end


--other functions
function DXGUIElement:setToFront()
	self.position = Vector3(self.position.x, self.position.y, 999999999999999)
end
function DXGUIElement:setToBack()
	self.position = Vector3(self.position.x, self.position.y, -999999999999999)
end

function DXGUIElement:triggerEvents()
	local element = self.element
	local position = self:getPosition()
	local size = self:getSize()
	
	if isMouseInRec(position.x, position.y, size.x, size.y) then --hover
		triggerEvent("OnDXGUIMouseHover", element)
		
		if !self:getMouseHover() then
			self:setMouseHover(true)
			triggerEvent("OnDXGUIMouseEnter", element)
		end
		
		if getKeyState("mouse1") then --click
			triggerEvent("OnDXGUIMouseClickBounce", element)
		end
	else
		if self:getMouseHover() then
			self:setMouseHover(false)
			triggerEvent("OnDXGUIMouseLeave", element)
		end
	end
end

function DXGUIElement:startAnimation(pos, size, colour, easeFunction, elapseTime)
	self.animation = true
	self.animPosition = pos
	self.animSize = size
	self.animColour = colour
	self.animFunction = easeFunction
	self.animElapseTime = elapseTime
	self.animStartTime = getTickCount()
	
	triggerEvent("OnDXGUIElementAnimationStarted", self.element)
	
	--add animation handler
	addEventHandler("onClientRender", self.element, animateDXGUIElement)
end
function DXGUIElement:endAnimation()
	self.animation = false
	triggerEvent("OnDXGUIElementAnimationEnded", self.element)
	
	--remove animation handler
	removeEventHandler("onClientRender", self.element, animateDXGUIElement) --syntax correct?
end

--events
addEvent("OnDXGUIMouseHover")
addEvent("OnDXGUIMouseEnter")
addEvent("OnDXGUIMouseLeave")
addEvent("OnDXGUIFocus") --input class
addEvent("OnDXGUIMouseClick") --after bounce remove
addEvent("OnDXGUIMouseClickBounce") --before bounce remove
addEvent("OnDXGUIElementStartRendering")
--addEvent("OnDXGUIElementRendering")
addEvent("OnDXGUIElementStoppedRendering")
addEvent("OnDXGUIElementAnimationStarted")
addEvent("OnDXGUIElementAnimationEnded")




