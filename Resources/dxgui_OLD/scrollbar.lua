addEvent("onDXScrollbarClick")
addEvent("onDXScrollbarScrollWheel")
addEvent("onDXScrollbarScroll")

function dxCreateScrollbar(x, y, width, height, id, postgui, parent)
	if not x or not y or not width or not height or not id then
		outputDebugString("dxCreateScrollbar gets wrong parameters (x, y, width, height, id[, postgui, parent=dxRootElement])")
		return
	end
	local dxScrollbar = createElement("dxScrollbar", id)
	setElementData(dxScrollbar, "X", x)
	setElementData(dxScrollbar, "Y", y)
	setElementData(dxScrollbar, "Width", width)
	setElementData(dxScrollbar, "Height", height)
	setElementData(dxScrollbar, "Index", 0)
	setElementData(dxScrollbar, "TotalRows", 0)
	setElementData(dxScrollbar, "MouseEnter", false)
	setElementData(dxScrollbar, "Visibility", true)
	if postgui then
		setElementData(dxScrollbar, "PostGUI", true)
	else
		setElementData(dxScrollbar, "PostGUI", false)
	end
	if parent then
		setElementParent(dxScrollbar, parent)
	else
		setElementParent(dxScrollbar, dxRootElement)
	end
	
	addEventHandler("onDXScrollbarClick",dxScrollbar,
	function() 
		local y = getElementData(source, "Y")
		local height = getElementData(source, "Height")
		local totalRows = getElementData(dxScrollbar, "TotalRows")
		local maximumRows = height/(heightScale*30)
		if totalRows < maximumRows then
			totalRows = maximumRows
		end
		local scrollbarHeight = (height/(totalRows*(heightScale*30)))*height
		local mouseX, mouseY = getCursorPosition()
		mouseY = mouseY*screenHeight
		local index = (mouseY-y-scrollbarHeight/2)/height*100
		local scrollbarY = y+((index)/100)*height
		if index >= 0 and index <= 100-(height/(totalRows*(heightScale*30)))*100 then
			setElementData(source, "Index", index)
			triggerEvent("onDXScrollbarScroll", source, index)
		elseif index < 0 then
			setElementData(source, "Index", 0)
			triggerEvent("onDXScrollbarScroll", source, index)
		end
	end)
	
	addEventHandler("onDXScrollbarScrollWheel",dxScrollbar,
	function(direction) 
		if direction=="mouse_wheel_up" then
			local height = getElementData(source, "Height")
			local totalRows = getElementData(dxScrollbar, "TotalRows")
			local maximumRows = height/(heightScale*30)
			if totalRows < maximumRows then
				totalRows = maximumRows
			end
			local index = getElementData(source, "Index")-1
			if index >= 0 and index <= 100-(height/(totalRows*(heightScale*30)))*100 then
				setElementData(source, "Index", index)
				triggerEvent("onDXScrollbarScroll", source, index)
			elseif index < 0 then
				setElementData(source, "Index", 0)
				triggerEvent("onDXScrollbarScroll", source, index)
			end
		elseif direction=="mouse_wheel_down" then
			local height = getElementData(source, "Height")
			local totalRows = getElementData(dxScrollbar, "TotalRows")
			local maximumRows = height/(heightScale*30)
			if totalRows < maximumRows then
				totalRows = maximumRows
			end
			local index = getElementData(source, "Index")+1
			if index >= 0 and index <= 100-(height/(totalRows*(heightScale*30)))*100 then
				setElementData(source, "Index", index)
				triggerEvent("onDXScrollbarScroll", source, index)
			elseif index < 0 then
				setElementData(source, "Index", 0)
				triggerEvent("onDXScrollbarScroll", source, index)
			end
		end
	end)
	
	addEventHandler( "onClientKey", root,
    function(button, press)
		if (button=="mouse_wheel_down" or button=="mouse_wheel_up") and press then
			triggerEvent("onDXScrollbarScrollWheel", dxScrollbar, button)
		end
    end)
	return dxScrollbar
end

function dxGetScrollbarIndex(dxScrollbar)
	return getElementData(dxScrollbar, "Index")
end
function dxSetScrollbarIndex(dxScrollbar, value)
	return setElementData(dxScrollbar, "Index", value)
end

function renderDXScrollbar(dxScrollbar)
	if not getElementData(dxScrollbar, "Visibility") then
		return
	end
	local x = getElementData(dxScrollbar, "X")
	local y = getElementData(dxScrollbar, "Y")
	local width = getElementData(dxScrollbar, "Width")
	local height = getElementData(dxScrollbar, "Height")
	local index = getElementData(dxScrollbar, "Index")
	local totalRows = getElementData(dxScrollbar, "TotalRows")
	local maximumRows = height/(heightScale*30)
	if totalRows < maximumRows then
		totalRows = maximumRows
	end
	local scrollbarY = y+((index)/100)*height
	local scrollbarHeight = (height/(totalRows*(heightScale*30)))*height
	local postgui = getElementData(dxScrollbar, "PostGUI")
	dxDrawRectangle(x, y, width, height, tocolor(60,60,60,155), postgui, true)
	dxDrawRectangle(x+1, scrollbarY, width-1, scrollbarHeight, tocolor(0,0,0,255), postgui, true)
	dxDrawLine(x, y, x+width, y, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x, y, x, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x+width, y, x+width, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x, y+height, x+width, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	if isMouseInRec(x,y,width,height) then --hover
		if getKeyState("mouse1") then --click
			triggerEvent("onDXScrollbarClick", dxScrollbar)
		end	
	end
	if getKeyState("mouse_wheel_up") then
		triggerEvent("onDXScrollbarScrollWheel", dxScrollbar, "up")
	end
	if getKeyState("mouse_wheel_down") then
		triggerEvent("onDXScrollbarScrollWheel", dxScrollbar, "down")
	end
	
	if isMouseInRec(x,y,width,height) then --hover event
		if not getElementData(dxScrollbar, "MouseEnter") then
			triggerEvent("onDXElementMouseEnter", dxScrollbar)
			setElementData(dxScrollbar, "MouseEnter", true)
		end
	else
		if getElementData(dxScrollbar, "MouseEnter") then
			triggerEvent("onDXElementMouseLeave", dxScrollbar)
			setElementData(dxScrollbar, "MouseEnter", false)
		end
	end
end

function resetDXScrollbar(dxScrollbar)
	return setElementData(dxScrollbar, "Index", 0)
end
