addEvent("onDXWindowResize")

function dxCreateWindow(x, y, width, height, id, title, postgui, parent)
	if not x or not y or not width or not height or not id then
		outputDebugString("dxCreateWindow gets wrong parameters (x, y, width, height, id[, title, postgui, parent=dxRootElement])")
		return
	end
	local dxWindow = createElement("dxWindow", id)
	setElementData(dxWindow, "X", x)
	setElementData(dxWindow, "Y", y)
	setElementData(dxWindow, "Width", width)
	setElementData(dxWindow, "Height", height)
	setElementData(dxWindow, "MouseEnter", false)
	setElementData(dxWindow, "State", "full")
	setElementData(dxWindow, "Visibility", true)
	if title then
		setElementData(dxWindow, "Title", title)
	end
	if postgui then
		setElementData(dxWindow, "PostGUI", true)
	else
		setElementData(dxWindow, "PostGUI", false)
	end
	if parent then
		setElementParent(dxWindow, parent)
	else
		setElementParent(dxWindow, dxRootElement)
	end
	return dxWindow
end

function renderDXWindow(dxWindow)
	if not getElementData(dxWindow, "Visibility") then
		return
	end
	local state = getElementData(dxWindow, "State")
	local x = getElementData(dxWindow, "X")
	local y = getElementData(dxWindow, "Y")
	local width = getElementData(dxWindow, "Width")
	local height = getElementData(dxWindow, "Height")
	local title = getElementData(dxWindow, "Title")
	local postgui = getElementData(dxWindow, "PostGUI")
	dxDrawRectangle(x, y, width, heightScale*35, tocolor(0,200,255,255), postgui, true)
	if title then
		dxDrawText(title, x, y, x+width, y+heightScale*35, tocolor(255,255,255, 255), getFontSize(currentWindow, heightScale*30, width), "arial", "center", "center", true, false, postgui, false, true)	
	end
	if state == "full" then
		dxDrawLine(x+width-heightScale*35+5, y-10+heightScale*35, x+width-5, y-10+heightScale*35, tocolor(255,255,255,255), 2, postgui)
		if isMouseInRec(x+width-heightScale*35+5,y,width-(width-heightScale*35+5),heightScale*35) then
			dxDrawLine(x+width-heightScale*35+5, y-10+heightScale*35, x+width-5, y-10+heightScale*35, tocolor(255,255,255,255), 3, postgui)
			if getKeyState("mouse1") then --click
				if dxGUIBounce then
					startBounceControl()
					setElementData(dxWindow, "State", "minimalised")
					triggerEvent("onDXWindowResize", dxWindow, "minimalised")
					local children = getElementChildren(dxWindow)
					for i, child in pairs(children) do
						dxSetVisibility(child, false)
					end
				end
			end	
		end
	elseif state == "minimalised" then
		dxDrawLine(x+width-heightScale*35+7, y-10+heightScale*35, x+width-heightScale*35+7, y+10, tocolor(255,255,255,255), 1, postgui)
		dxDrawLine(x+width-7, y-10+heightScale*35, x+width-7, y+10, tocolor(255,255,255,255), 1, postgui)
		dxDrawLine(x+width-heightScale*35+7, y+10, x+width-7, y+10, tocolor(255,255,255,255), 1, postgui)
		dxDrawLine(x+width-7, y-10+heightScale*35, x+width-heightScale*35+7, y-10+heightScale*35, tocolor(255,255,255,255), 1, postgui)
		if isMouseInRec(x+width-heightScale*35+5,y,width-(width-heightScale*35+5),heightScale*35) then
			dxDrawLine(x+width-heightScale*35+7, y-10+heightScale*35, x+width-heightScale*35+7, y+10, tocolor(255,255,255,255), 2, postgui)
			dxDrawLine(x+width-7, y-10+heightScale*35, x+width-7, y+10, tocolor(255,255,255,255), 2, postgui)
			dxDrawLine(x+width-heightScale*35+7, y+10, x+width-7, y+10, tocolor(255,255,255,255), 2, postgui)
			dxDrawLine(x+width-7, y-10+heightScale*35, x+width-heightScale*35+7, y-10+heightScale*35, tocolor(255,255,255,255), 2, postgui)
			if getKeyState("mouse1") then --click
				if dxGUIBounce then
					startBounceControl()
					setElementData(dxWindow, "State", "full")
					triggerEvent("onDXWindowResize", dxWindow, "full")
					local children = getElementChildren(dxWindow)
					for i, child in pairs(children) do
						dxSetVisibility(child, true)
					end
				end
			end	
		end
		return
	end
	dxDrawRectangle(x, y+heightScale*35, width, height-heightScale*35, tocolor(0,0,0,180), postgui, true)
	if isMouseInRec(x,y,width,height) then --hover event
		if not getElementData(dxWindow, "MouseEnter") then
			triggerEvent("onDXElementMouseEnter", dxWindow)
			setElementData(dxWindow, "MouseEnter", true)
		end
	else
		if getElementData(dxWindow, "MouseEnter") then
			triggerEvent("onDXElementMouseLeave", dxWindow)
			setElementData(dxWindow, "MouseEnter", false)
		end
	end
end

function resetDXWindow(dxWindow)
	
end