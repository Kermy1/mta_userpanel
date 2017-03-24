local windowColour = Vector4(50, 241, 238, 82)
local windowPosition = Vector3(screenWidth/2-500, screenHeight/2-250, 0)
local windowSize = Vector2(1000,500)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
function()	
	local window = DXGUIWindow:new("DXGUIWindow")
	window:setPosition(windowPosition)
	window:setSize(windowSize)
	window:setColour(windowColour)
	window:setTitle("test")
	window:setVisible(true)
	
	
	--outputDebugString(table.tostring(window))
	--outputDebugString(window:getSubClassName())
end)



