dxRootElement = createElement("dxRoot")
addEvent("onDXElementMouseEnter")
addEvent("onDXElementMouseLeave")


function renderDXElement(element)
	if not element then
		outputDebugString("renderDXElement gets wrong parameters (dxElement)")
		return
	end
	local type = getElementType(element)
	if type == "dxWindow" then
		renderDXWindow(element)
	elseif type == "dxButton" then
		renderDXButton(element)
	elseif type == "dxCheckbox" then
		renderDXCheckbox(element)
	elseif type == "dxList" then
		renderDXList(element)
	elseif type == "dxEdit" then
		renderDXEdit(element)
	elseif type == "dxScrollbar" then
		renderDXScrollbar(element)
	elseif type == "dxLabel" then
		renderDXLabel(element)
	end
	local children = getElementChildren(element)
	for i, child in pairs(children) do
		renderDXElement(child)
	end
end

function resetAllDXElements()
	for i, child in pairs(getElementChildren(dxRootElement)) do
		resetDXElement(child)
	end
end

function resetDXElement(element)
	if not element then
		outputDebugString("renderDXElement gets wrong parameters (dxElement)")
		return
	end
	local type = getElementType(element)
	if type == "dxWindow" then
		resetDXWindow(element)
	elseif type == "dxButton" then
		resetDXButton(element)
	elseif type == "dxCheckbox" then
		resetDXCheckbox(element)
	elseif type == "dxList" then
		resetDXList(element)
	elseif type == "dxEdit" then
		resetDXEdit(element)
	elseif type == "dxScrollbar" then
		resetDXScrollbar(element)
	elseif type == "dxLabel" then
		resetDXLabel(element)
	end
	setElementData(element, "Visibility", true)
	local children = getElementChildren(element)
	for i, child in pairs(children) do
		resetDXElement(child)
	end
end


function dxSetVisibility(element, bool)
	if not element or bool==nil then
		outputDebugString("dxSetVisibility gets wrong parameters (dxElement, bool)")
		return
	end
	setElementData(element, "Visibility", bool)
	local children = getElementChildren(element)
	for i, child in pairs(children) do
		dxSetVisibility(child, bool)
	end
end

dxGUIBounce = true
function startBounceControl()
	dxGUIBounce = false
	setTimer(resetBounceControl, 250, 1)
end
function resetBounceControl()
	dxGUIBounce = true
end