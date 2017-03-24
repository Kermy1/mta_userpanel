addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
function()	
	mainMenuBaseGUIElement = DXGUIElement:new("MainMenu")
	
	statsGUIMenuItem = DXGUIMenuItem:new("StatsMenuItem", "Stats", "Resources/Icons/statsIcon.png")
	statsGUIMenuItem:setParent(mainMenuBaseGUIElement)
	mainMenuBaseGUIElement:addChild(statsGUIMenuItem)
	
	rankingGUIMenuItem = DXGUIMenuItem:new("RankingsMenuItem", "Ranking", "Resources/Icons/rankingIcon.png")
	rankingGUIMenuItem:setParent(mainMenuBaseGUIElement)
	mainMenuBaseGUIElement:addChild(rankingGUIMenuItem)
	
	playersGUIMenuItem = DXGUIMenuItem:new("PlayersMenuItem", "Players", "Resources/Icons/playersIcon.png")
	playersGUIMenuItem:setParent(mainMenuBaseGUIElement)
	mainMenuBaseGUIElement:addChild(playersGUIMenuItem)
	
	mapsGUIMenuItem = DXGUIMenuItem:new("MapsMenuItem", "Maps", "Resources/Icons/mapsIcon.png")
	mapsGUIMenuItem:setParent(mainMenuBaseGUIElement)
	mainMenuBaseGUIElement:addChild(mapsGUIMenuItem)
	
	garageGUIMenuItem = DXGUIMenuItem:new("GarageMenuItem", "Garage", "Resources/Icons/garageIcon.png")
	garageGUIMenuItem:setParent(mainMenuBaseGUIElement)
	mainMenuBaseGUIElement:addChild(garageGUIMenuItem)
	
	settingGUIMenuItem = DXGUIMenuItem:new("SettingMenuItem", "Setting", "Resources/Icons/settingIcon.png")
	settingGUIMenuItem:setParent(mainMenuBaseGUIElement)
	mainMenuBaseGUIElement:addChild(settingGUIMenuItem)
	
	--if player is admin then
		adminGUIMenuItem = DXGUIMenuItem:new("AdminMenuItem", "Admin", "Resources/Icons/adminIcon.png")
		adminGUIMenuItem:setParent(mainMenuBaseGUIElement)
		mainMenuBaseGUIElement:addChild(adminGUIMenuItem)
	--end
end)