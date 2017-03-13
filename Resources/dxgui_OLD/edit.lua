addEvent("onDXEditClick")
addEvent("onDXEditAddCharacter")
addEvent("onDXEditBackspace")
addEvent("onDXEditArrowLeft")
addEvent("onDXEditArrowRight")
addEvent("onDXEditFocus") --todo?

function dxCreateEdit(x, y, width, height, placeholder, id, postgui, numbermode, parent)
	if not x or not y or not width or not height or not placeholder or not id then
		outputDebugString("dxCreateEdit gets wrong parameters (x, y, width, height, placeholder, id[, postgui, numbermode, parent=dxRootElement])")
		return
	end
	local dxEdit = createElement("dxEdit", id)
	setElementData(dxEdit, "X", x)
	setElementData(dxEdit, "Y", y)
	setElementData(dxEdit, "Width", width)
	setElementData(dxEdit, "Height", height)
	setElementData(dxEdit, "Placeholder", placeholder)
	setElementData(dxEdit, "Input", "")
	setElementData(dxEdit, "Index", 0)
	setElementData(dxEdit, "Focus", false)
	setElementData(dxEdit, "MouseEnter", false)
	setElementData(dxEdit, "Visibility", true)
	if numbermode then
		setElementData(dxEdit, "numbermode", true)
	else
		setElementData(dxEdit, "numbermode", false)
	end
	if postgui then
		setElementData(dxEdit, "PostGUI", true)
	else
		setElementData(dxEdit, "PostGUI", false)
	end
	if parent then
		setElementParent(dxEdit, parent)
	else
		setElementParent(dxEdit, dxRootElement)
	end
	
	addEventHandler("onDXEditClick", dxEdit,
    function()
		setElementData(source, "Focus", true)
		guiSetInputMode("no_binds")
		local x = getElementData(source, "X")
		local input = dxGetEditInput(source)
		local mouseX, mouseY = getCursorPosition()
		local fontSize = getFontSize(currentWindow, heightScale*30, width)
		mouseX = mouseX*screenWidth
		local textWidth = dxGetTextWidth(input, fontSize, "arial")
		local newIndex = round(((mouseX-x)/textWidth)*string.len(input))
		setElementData(source, "Index", newIndex)	
	end)
	addEventHandler("onDXEditAddCharacter", dxEdit,
    function(character)
		if not getElementData(source, "numbermode") then
			if getElementData(source, "Focus") then
				local input = dxGetEditInput(source)
				local index = getElementData(source, "Index")
				dxSetEditInput(source, string.sub(input,1,index)..character..string.sub(input,index+1))
				setElementData(source, "Index", getElementData(source, "Index")+1)	
			end
		elseif getElementData(source, "Focus") and string.match(character, '%d')~=nil then
			local input = dxGetEditInput(source)
			local index = getElementData(source, "Index")
			dxSetEditInput(source, string.sub(input,1,index)..character..string.sub(input,index+1))
			setElementData(source, "Index", getElementData(source, "Index")+1)	
		end
	end)
	addEventHandler("onDXEditBackspace", dxEdit,
    function()
		local input = dxGetEditInput(source)
		if getElementData(source, "Focus") then
			if string.len(input) > 0 then
				local input = dxGetEditInput(source)
				local index = getElementData(source, "Index")
				if index > 0 then
					dxSetEditInput(source, string.sub(input,1,index-1)..string.sub(input,index+1))
					setElementData(source, "Index", getElementData(source, "Index")-1)			
				end
			end
		end
	end)
	addEventHandler("onDXEditArrowLeft", dxEdit,
    function()
		if getElementData(source, "Focus") then
			local index = getElementData(source, "Index")
			if index > 0 then
				setElementData(source, "Index", index-1)
			end
		end
	end)
	addEventHandler("onDXEditArrowRight", dxEdit,
    function()
		if getElementData(source, "Focus") then
			local index = getElementData(source, "Index")
			if index < string.len(dxGetEditInput(source)) then
				setElementData(source, "Index", index+1)
			end
		end
	end)
	
	
	addEventHandler("onClientCharacter", root,
    function(character)
		triggerEvent("onDXEditAddCharacter", dxEdit, character)
    end)
	addEventHandler( "onClientKey", root,
    function(button, press)
		if button=="backspace" and press then
			triggerEvent("onDXEditBackspace", dxEdit)
		elseif button=="arrow_l" and press then
			triggerEvent("onDXEditArrowLeft", dxEdit)
		elseif button=="arrow_r" and press then
			triggerEvent("onDXEditArrowRight", dxEdit)
		end
    end)
	return dxEdit
end

function dxSetEditInput(dxEdit, input)
	if not dxEdit or not input then
		outputDebugString("dxSetEditInput gets wrong parameters (dxEdit, input)")
		return
	end
	return setElementData(dxEdit, "Input", input)
end
function dxGetEditInput(dxEdit)
	if not dxEdit then
		outputDebugString("dxGetEditInput gets wrong parameters (dxEdit)")
		return
	end
	return getElementData(dxEdit, "Input")
end

function renderDXEdit(dxEdit)
	if not getElementData(dxEdit, "Visibility") then
		return
	end
	local x = getElementData(dxEdit, "X")
	local y = getElementData(dxEdit, "Y")
	local width = getElementData(dxEdit, "Width")
	local height = getElementData(dxEdit, "Height")
	local placeholder = getElementData(dxEdit, "Placeholder")
	local input = getElementData(dxEdit, "Input")
	local index = getElementData(dxEdit, "Index")
	local focus = getElementData(dxEdit, "Focus")
	local fontSize = dxGetFontSizeFromHeight(height, "arial")
	local postgui = getElementData(dxEdit, "PostGUI")
	dxDrawRectangle(x, y, width, height, tocolor(255,255,255,255), postgui, true)
	dxDrawLine(x, y, x+width, y, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x, y, x, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x+width, y, x+width, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x, y+height, x+width, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	if input == "" then
		dxDrawText(placeholder, x, y, x+width, y+height, tocolor(0,0,0, 140), fontSize, "arial", "left", "center", true, false, postgui, false, true)
	else
		dxDrawText(input, x, y, x+width, y+height, tocolor(0,0,0, 255), fontSize, "arial", "left", "center", true, false, postgui, false, true)
	end
	if focus then
		local caretX = x + dxGetTextWidth(string.sub(input,1,index), fontSize, "arial")
		if caretX < x+width then
			dxDrawLine(caretX, y+2, caretX, y+height-4, tocolor(0,0,0,255), 2, postgui) --caret
			setElementData(dxEdit, "Caret", false)
		end
	end
	
	if isMouseInRec(x,y,width,height) then --hover
		if getKeyState("mouse1") then --click
			triggerEvent("onDXEditClick", dxEdit)
		end
	else
		if getKeyState("mouse1") then --click
			setElementData(dxEdit, "Focus", false)
			guiSetInputMode("allow_binds")
		end
	end
	
	if isMouseInRec(x,y,width,height) then --hover event
		if not getElementData(dxEdit, "MouseEnter") then
			triggerEvent("onDXElementMouseEnter", dxEdit)
			setElementData(dxEdit, "MouseEnter", true)
		end
	else
		if getElementData(dxEdit, "MouseEnter") then
			triggerEvent("onDXElementMouseLeave", dxEdit)
			setElementData(dxEdit, "MouseEnter", false)
		end
	end
end

function resetDXEdit(dxEdit)
	--dxSetEditInput(dxEdit, "")
	setElementData(dxEdit, "Focus", false)
end