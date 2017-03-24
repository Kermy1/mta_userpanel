local menuOpen = false

function toggleMenu()
	if menuOpen then --close menu
		menuOpen = false
		closeMenu()
	else 			 --open menu
		menuOpen = true
		openMenu()
	end
end
bindKey("u", "down", openMenu)

function openMenu()
	--mainMenuBaseGUIElement:setVisisble(true)
	for menuItem in mainMenuBaseGUIElement:getChildren() do
		local pos = menuItem:getPosition()
		local size = menuItem:getSize()
		local colour = menuItem:getColour()
		
		menuItem:endAnimation()
		menuItem:startAnimation(Vector3(size.x,pos.y,pos.z), size, colour, "OutElastic", 1000)
	end
end

function closeMenu()
	--mainMenuBaseGUIElement:setVisisble(false)
	for menuItem in mainMenuBaseGUIElement:getChildren() do
		local pos = menuItem:getPosition()
		local size = menuItem:getSize()
		local colour = menuItem:getColour()
		
		menuItem:endAnimation()
		menuItem:startAnimation(Vector3(0,pos.y,pos.z), size, colour, "InElastic", 1000)
	end
end