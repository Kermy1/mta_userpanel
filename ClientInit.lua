

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
function()	
	local window = DXGUIWindow:new("DXGUIWindow")
	window:setPosition(Vector3(screenWidth/2-500, screenHeight/2-250, 0))
	window:setSize(Vector2(1000,500))
	window:setColour(255,255,0,255)
	window:setVisible(true)
	
	--local label = DXGUILabel:new("DXGUILabel", "text")
	--label:setPosition(Vector3(screenWidth/2-500, screenHeight/2-250, 0))
	--label:setSize(Vector2(1000,500))
	--label:setFontSize("auto")
	--label:setParent(window)
	--outputDebugString(table.tostring(window))
	--outputDebugString(window:getSubClassName())
end)



