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
	
	
	mainMenuBaseGUIElement = DXGUIElement:new("MainMenu")
	
	statsGUIMenuItem = DXGUIMenuItem:new("StatsMenuItem", "Stats", "Resources/Icons/statsIcon.png")
	mainMenuBaseGUIElement:setParent(mainMenuBaseGUIElement)
	addChildToClass(mainMenuBaseGUIElement, mainMenuBaseGUIElement)
	
	rankingGUIMenuItem = DXGUIMenuItem:new("RankingsMenuItem", "Ranking", "Resources/Icons/rankingIcon.png")
	mainMenuBaseGUIElement:setParent(mainMenuBaseGUIElement)
	addChildToClass(mainMenuBaseGUIElement, mainMenuBaseGUIElement)
	
	playersGUIMenuItem = DXGUIMenuItem:new("PlayersMenuItem", "Players", "Resources/Icons/playersIcon.png")
	mainMenuBaseGUIElement:setParent(mainMenuBaseGUIElement)
	addChildToClass(mainMenuBaseGUIElement, mainMenuBaseGUIElement)
	
	mapsGUIMenuItem = DXGUIMenuItem:new("MapsMenuItem", "Maps", "Resources/Icons/mapsIcon.png")
	mainMenuBaseGUIElement:setParent(mainMenuBaseGUIElement)
	addChildToClass(mainMenuBaseGUIElement, mainMenuBaseGUIElement)
	
	garageGUIMenuItem = DXGUIMenuItem:new("GarageMenuItem", "Garage", "Resources/Icons/garageIcon.png")
	mainMenuBaseGUIElement:setParent(mainMenuBaseGUIElement)
	addChildToClass(mainMenuBaseGUIElement, mainMenuBaseGUIElement)
	
	settingGUIMenuItem = DXGUIMenuItem:new("SettingMenuItem", "Setting", "Resources/Icons/settingIcon.png")
	mainMenuBaseGUIElement:setParent(mainMenuBaseGUIElement)
	addChildToClass(mainMenuBaseGUIElement, mainMenuBaseGUIElement)
	
	--if player is admin then
		adminGUIMenuItem = DXGUIMenuItem:new("AdminMenuItem", "Admin", "Resources/Icons/adminIcon.png")
		mainMenuBaseGUIElement:setParent(mainMenuBaseGUIElement)
		addChildToClass(mainMenuBaseGUIElement, mainMenuBaseGUIElement)
	
	--end
	
	
	
	--outputDebugString(table.tostring(window))
	--outputDebugString(window:getSubClassName())
end)



