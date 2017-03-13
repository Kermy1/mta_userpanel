addEvent("onDXLabelClick") --todo

function dxCreateLabel(x, y, width, height, labelText, id, postgui, parent)
	if not x or not y or not width or not height or not labelText or not id then
		outputDebugString("dxCreateLabel gets wrong parameters (x, y, width, height, labelText, id[, postgui, parent=dxRootElement])")
		return
	end
	local dxLabel = createElement("dxLabel", id)
	setElementData(dxLabel, "X", x)
	setElementData(dxLabel, "Y", y)
	setElementData(dxLabel, "Width", width)
	setElementData(dxLabel, "Height", height)
	setElementData(dxLabel, "LabelText", labelText)
	setElementData(dxLabel, "MouseEnter", false)
	setElementData(dxLabel, "Visibility", true)
	if postgui then
		setElementData(dxLabel, "PostGUI", true)
	else
		setElementData(dxLabel, "PostGUI", false)
	end
	if parent then
		setElementParent(dxLabel, parent)
	else
		setElementParent(dxLabel, dxRootElement)
	end
	return dxLabel
end

function renderDXLabel(dxLabel)
	if not getElementData(dxLabel, "Visibility") then
		return
	end
	local x = getElementData(dxLabel, "X")
	local y = getElementData(dxLabel, "Y")
	local width = getElementData(dxLabel, "Width")
	local height = getElementData(dxLabel, "Height")
	local labelText = getElementData(dxLabel, "LabelText")
	local postgui = getElementData(dxLabel, "PostGUI")
	dxDrawText(labelText, x, y, x+width, y+height, tocolor(255,255,255, 255), getFontSize(labelText, height, width), "arial", "left", "center", true, false, postgui, false, true)
	if isMouseInRec(x,y,width,height) then
		if getKeyState("mouse1") then --click
			triggerEvent("onDXLabelClick", dxLabel)
		end
		if not getElementData(dxLabel, "MouseEnter") then
			triggerEvent("onDXElementMouseEnter", dxLabel)
			setElementData(dxLabel, "MouseEnter", true)
		end
	else
		if getElementData(dxLabel, "MouseEnter") then
			triggerEvent("onDXElementMouseLeave", dxLabel)
			setElementData(dxLabel, "MouseEnter", false)
		end
	end
end

function resetDXLabel(dxLabel)
	
end