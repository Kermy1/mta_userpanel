addEvent("onDXCheckboxClick")

function dxCreateCheckbox(x, y, width, height, id, postgui, parent)
	if not x or not y or not width or not height or not id then
		outputDebugString("dxCreateCheckBox gets wrong parameters (x, y, width, height, id[, postgui, parent=dxRootElement])")
		return
	end
	local dxCheckbox = createElement("dxCheckbox", id)
	setElementData(dxCheckbox, "X", x)
	setElementData(dxCheckbox, "Y", y)
	setElementData(dxCheckbox, "Width", width)
	setElementData(dxCheckbox, "Height", height)
	setElementData(dxCheckbox, "Checked", false)
	setElementData(dxCheckbox, "MouseEnter", false)
	setElementData(dxCheckbox, "Visibility", true)
	if postgui then
		setElementData(dxCheckbox, "PostGUI", true)
	else
		setElementData(dxCheckbox, "PostGUI", false)
	end
	if parent then
		setElementParent(dxCheckbox, parent)
	else
		setElementParent(dxCheckbox, dxRootElement)
	end
	addEventHandler("onDXCheckboxClick",dxCheckbox, 
	function() 	
		if dxGUIBounce then
			startBounceControl()
			local temp = nil
			if dxGetCheckboxInput(source) then
				temp = false
			else
				temp = true
			end
			dxSetCheckboxInput(source, temp)
		end
	end)
	return dxCheckbox
end

function dxSetCheckboxInput(dxCheckbox, checked)
	if not dxCheckbox or checked==nil then
		outputDebugString("dxSetCheckboxInput gets wrong parameters (dxCheckBox, bool)")
		return
	end
	return setElementData(dxCheckbox, "Checked", checked)
end
function dxGetCheckboxInput(dxCheckbox)
	if not dxCheckbox then
		outputDebugString("dxGetCheckboxInput gets wrong parameters (dxCheckBox)")
		return
	end
	return getElementData(dxCheckbox, "Checked")
end

function renderDXCheckbox(dxCheckbox)
	if not getElementData(dxCheckbox, "Visibility") then
		return
	end
	local x = getElementData(dxCheckbox, "X")
	local y = getElementData(dxCheckbox, "Y")
	local width = getElementData(dxCheckbox, "Width")
	local height = getElementData(dxCheckbox, "Height")
	local checked = getElementData(dxCheckbox, "Checked")
	local postgui = getElementData(dxCheckbox, "PostGUI")
	dxDrawRectangle(x, y, width, height, tocolor(0,0,0,255), postgui, true)
	dxDrawLine(x, y, x+width, y, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x, y, x, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x+width, y, x+width, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x, y+height, x+width, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	if checked then
		dxDrawLine(x, y, x+width, y+height, tocolor(255,255,255,255), 2, postgui) --cross
		dxDrawLine(x+width, y, x, y+height, tocolor(255,255,255,255), 2, postgui) --cross		
	end
	if isMouseInRec(x,y,width,height) then --hover
		dxDrawLine(x, y, x+width, y, tocolor(255,255,255,255), 1, postgui) --outline
		dxDrawLine(x, y, x, y+height, tocolor(255,255,255,255), 1, postgui) --outline
		dxDrawLine(x+width, y, x+width, y+height, tocolor(255,255,255,255), 1, postgui) --outline
		dxDrawLine(x, y+height, x+width, y+height, tocolor(255,255,255,255), 1, postgui) --outline
		if getKeyState("mouse1") then --click
			triggerEvent("onDXCheckboxClick", dxCheckbox)
		end
	end
	
	if isMouseInRec(x,y,width,height) then --hover event
		if not getElementData(dxCheckbox, "MouseEnter") then
			triggerEvent("onDXElementMouseEnter", dxCheckbox)
			setElementData(dxCheckbox, "MouseEnter", true)
		end
	else
		if getElementData(dxCheckbox, "MouseEnter") then
			triggerEvent("onDXElementMouseLeave", dxCheckbox)
			setElementData(dxCheckbox, "MouseEnter", false)
		end
	end
end

function resetDXCheckbox(dxCheckbox)
	dxSetCheckboxInput(dxCheckbox, false)
end