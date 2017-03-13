addEvent("onDXButtonClick")
addEvent("onDXButtonClickInside")

function dxCreateButton(x, y, width, height, buttonText, id, postgui, parent)
	if not x or not y or not width or not height or not buttonText or not id then
		outputDebugString("dxCreateButton gets wrong parameters (x, y, width, height, buttonText, id[, postgui, parent=dxRootElement])")
		return
	end
	local dxButton = createElement("dxButton", id)
	setElementData(dxButton, "X", x)
	setElementData(dxButton, "Y", y)
	setElementData(dxButton, "Width", width)
	setElementData(dxButton, "Height", height)
	setElementData(dxButton, "ButtonText", buttonText)
	setElementData(dxButton, "MouseEnter", false)
	setElementData(dxButton, "Visibility", true)
	if postgui then
		setElementData(dxButton, "PostGUI", true)
	else
		setElementData(dxButton, "PostGUI", false)
	end
	if parent then
		setElementParent(dxButton, parent)
	else
		setElementParent(dxButton, dxRootElement)
	end
	addEventHandler("onDXButtonClickInside",dxButton, 
	function() 	
		if dxGUIBounce then
			startBounceControl()
			triggerEvent("onDXButtonClick", source)
		end
	end)
	return dxButton
end

function renderDXButton(dxButton)
	if not getElementData(dxButton, "Visibility") then
		return
	end
	local x = getElementData(dxButton, "X")
	local y = getElementData(dxButton, "Y")
	local width = getElementData(dxButton, "Width")
	local height = getElementData(dxButton, "Height")
	local buttonText = getElementData(dxButton, "ButtonText")
	local postgui = getElementData(dxButton, "PostGUI")
	dxDrawRectangle(x, y, width, height, tocolor(0,0,0,255), postgui, true)
	dxDrawLine(x, y, x+width, y, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x, y, x, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x+width, y, x+width, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x, y+height, x+width, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawText(buttonText, x, y, x+width, y+height, tocolor(255,255,255, 255), getFontSize(currentWindow, heightScale*30, width), "arial", "center", "center", true, false, postgui, false, true)
	if isMouseInRec(x,y,width,height) then --hover
		dxDrawLine(x, y, x+width, y, tocolor(255,255,255,255), 1, postgui) --outline
		dxDrawLine(x, y, x, y+height, tocolor(255,255,255,255), 1, postgui) --outline
		dxDrawLine(x+width, y, x+width, y+height, tocolor(255,255,255,255), 1, postgui) --outline
		dxDrawLine(x, y+height, x+width, y+height, tocolor(255,255,255,255), 1, postgui) --outline
		if getKeyState("mouse1") then --click
			triggerEvent("onDXButtonClickInside", dxButton)
		end
	end
	
	if isMouseInRec(x,y,width,height) then --hover event
		if not getElementData(dxButton, "MouseEnter") then
			triggerEvent("onDXElementMouseEnter", dxButton)
			setElementData(dxButton, "MouseEnter", true)
		end
	else
		if getElementData(dxButton, "MouseEnter") then
			triggerEvent("onDXElementMouseLeave", dxButton)
			setElementData(dxButton, "MouseEnter", false)
		end
	end
end

function resetDXButton(dxButton)
	
end