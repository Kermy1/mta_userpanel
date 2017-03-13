addEvent("onDXListRowClick")
addEvent("onDXListRowClickInside")

function dxCreateList(x, y, width, height, id, dxScrollbar, postgui, parent)
	if not x or not y or not width or not height or not id then
		outputDebugString("dxCreateList gets wrong parameters (x, y, width, height, id[, postgui, dxScrollbar, parent=dxRootElement])")
		return
	end
	local dxList = createElement("dxList", id)
	setElementData(dxList, "X", x)
	setElementData(dxList, "Y", y)
	setElementData(dxList, "Width", width)
	setElementData(dxList, "Height", height)
	setElementData(dxList, "MouseEnter", false)
	setElementData(dxList, "Visibility", true)
	if dxScrollbar then
		setElementParent(dxScrollbar, dxList)
	end
	if postgui then
		setElementData(dxList, "PostGUI", true)
	else
		setElementData(dxList, "PostGUI", false)
	end
	if parent then
		setElementParent(dxList, parent)
	else
		setElementParent(dxList, dxRootElement)
	end
	addEventHandler("onDXListRowClickInside",dxList, 
	function(row) 	
		if dxGUIBounce then
			startBounceControl()
			triggerEvent("onDXListRowClick", source, row)
		end
	end)
	return dxList
end

function dxAddListRow(dxList, row, value, colour)   -- add colour optional
	if getElementType(dxList) ~= "dxList" or type(row) ~= "string" then
		outputDebugString("dxAddListRow gets wrong parameters (dxList, row[, value, colour(hex)])")
		return
	end
	local dxScrollbar = getElementsByType("dxScrollbar", dxList)[1]
	if dxScrollbar then
		setElementData(dxScrollbar, "TotalRows", getElementData(dxScrollbar, "TotalRows")+1)
	end
	local dxRow = createElement("dxRow", row)
	setElementData(dxRow, "Text", row)
	setElementData(dxRow, "Selected", false)
	if value then
		setElementData(dxRow, "Value", value)
	end
	if colour then
		setElementData(dxRow, "Colour", colour)
	else
		setElementData(dxRow, "Colour", "#FFFFFF")
	end
	setElementParent(dxRow, dxList)
	return dxRow
end

function dxRemoveListRow(dxList, row)
	if getElementType(dxList) ~= "dxList" or type(row) ~= "string" then
		outputDebugString("dxRemoveListRow gets wrong parameters (dxList, row)")
		return
	end
	local dxScrollbar = getElementsByType("dxScrollbar", dxList)[1]
	if dxScrollbar then
		setElementData(dxScrollbar, "TotalRows", getElementData(dxScrollbar, "TotalRows")-1)
	end
	local toDelete = nil
	for i, dxRow in ipairs(getElementsByType("dxRow", dxList)) do
		if getElementData(dxRow, "Text") == row then
			toDelete = dxRow
		end
	end
	return destroyElement(toDelete)
end

function dxEmptyList(dxList)
	if getElementType(dxList) ~= "dxList" then
		outputDebugString("dxEmptyList(dxList)")
		return
	end
	local dxScrollbar = getElementsByType("dxScrollbar", dxList)[1]
	if dxScrollbar then
		setElementData(dxScrollbar, "TotalRows", 0)
	end
	for i, dxRow in ipairs(getElementsByType("dxRow", dxList)) do
		destroyElement(dxRow)
	end
end

function dxGetSelectedRowName(dxList)
	if getElementType(dxList) ~= "dxList" then
		outputDebugString("dxGetSelectedRowName gets wrong parameters (dxList)")
		return
	end
	for i, row in ipairs(getElementsByType("dxRow", dxList)) do
		if getElementData(row, "Selected") then
			return getElementData(row, "Text")
		end
	end
	return false
end
function dxGetSelectedRowValue(dxList)
	if getElementType(dxList) ~= "dxList" then
		outputDebugString("dxGetSelectedRowValue gets wrong parameters (dxList)")
		return
	end
	for i, row in ipairs(getElementsByType("dxRow", dxList)) do
		if getElementData(row, "Selected") then
			return getElementData(row, "Value")
		end
	end
	return false
end

function dxSetSelectedRow(dxList, dxRow)
	if getElementType(dxList) ~= "dxList" or getElementType(dxRow) ~= "dxRow" then
		outputDebugString("dxSetSelectedRow gets wrong parameters (dxList, dxRow)")
		return
	end
	for i, row in ipairs(getElementsByType("dxRow", dxList)) do
		setElementData(row, "Selected", false)
	end
	setElementData(dxRow, "Selected", true)
end

function dxUnselectAllRows(dxList)
	for i, row in ipairs(getElementsByType("dxRow", dxList)) do
		setElementData(row, "Selected", false)
	end
end

function renderDXList(dxList)
	if not getElementData(dxList, "Visibility") then
		return
	end
	local x = getElementData(dxList, "X")
	local y = getElementData(dxList, "Y")
	local width = getElementData(dxList, "Width")
	local height = getElementData(dxList, "Height")
	local dxScrollbar = getElementsByType("dxScrollbar", dxList)[1]
	local postgui = getElementData(dxList, "PostGUI")
	dxDrawRectangle(x, y, width, height, tocolor(0,0,0,255), postgui, true)
	dxDrawLine(x, y, x+width, y, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x, y, x, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x+width, y, x+width, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	dxDrawLine(x, y+height, x+width, y+height, tocolor(255,255,255,100), 1, postgui) --outline
	local maximumRows = math.ceil(height/(heightScale*30))
	local totalRows = #getElementChildren(dxList)
	local totalHeight = totalRows*heightScale*30
	local rows = getElementsByType("dxRow", dxList)
	local index = getElementData(dxScrollbar, "Index")
	local temp = (#rows*(index/100))
	local temp2 = temp-math.floor(temp)
	local scrollbarHeight = (height/(totalRows*(heightScale*30)))*height
	for i=1-temp2, #rows+temp2, 1 do
		local row = rows[math.ceil(i)+math.floor(temp)]
		if i <= maximumRows+temp2 then
			if isMouseInRec(x,y+heightScale*30*(i-1),width,heightScale*30) then --hover
				if y+heightScale*30*i < y+height then
					dxDrawRectangle(x, y+heightScale*30*(i-1), width, heightScale*30, tocolor(0,200,255,100), postgui, true)
				else
					dxDrawRectangle(x, y+heightScale*30*(i-1), width, y+height-(y+heightScale*30*(i-1)), tocolor(0,200,255,100), postgui, true)
				end
				if getKeyState("mouse1") or getKeyState("mouse2") then --click
					dxSetSelectedRow(dxList, row)
					triggerEvent("onDXListRowClickInside", dxList, row)
				end
			end
			local text = getElementData(row, "Text")
			local r,g,b = hex2rgb(getElementData(row, "Colour"))
			local colour = tocolor(r,g,b,255)
			local fontSize = getFontSize(text, heightScale*30, width-2)
			if y+heightScale*30*i < y+height and y+heightScale*30*(i-1) > y then
				if getElementData(row, "Selected") then
					dxDrawRectangle(x, y+heightScale*30*(i-1), width, heightScale*30, tocolor(0,200,255,200), postgui, true)
				end
				dxDrawText(text, x+3, y+heightScale*30*(i-1), x+width-3, y+heightScale*30*i, colour, fontSize, "arial", "left", "top", true, false, postgui, false, true)
			elseif y+heightScale*30*(i-1) <= y then
				if getElementData(row, "Selected") then
					dxDrawRectangle(x, y, width, y+heightScale*30*i-y, tocolor(0,200,255,200), postgui, true)
				end
				dxDrawText(text, x+3, y, x+width-3, y+heightScale*30*i, colour, fontSize, "arial", "left", "bottom", true, false, postgui, false, true)
			elseif y+heightScale*30*i > y+height then
				if getElementData(row, "Selected") then
					dxDrawRectangle(x, y+heightScale*30*(i-1), width, y+height-(y+heightScale*30*(i-1)), tocolor(0,200,255,200), postgui, true)
				end
				dxDrawText(text, x+3, y+heightScale*30*(i-1), x+width-3, y+height, colour, fontSize, "arial", "left", "top", true, false, postgui, false, true)
			end
		else
			break	
		end
	end
	
	if isMouseInRec(x,y,width,height) then --hover event
		if not getElementData(dxList, "MouseEnter") then
			triggerEvent("onDXElementMouseEnter", dxList)
			setElementData(dxList, "MouseEnter", true)
		end
	else
		if getElementData(dxList, "MouseEnter") then
			triggerEvent("onDXElementMouseLeave", dxList)
			setElementData(dxList, "MouseEnter", false)
		end
	end
end

function resetDXList(dxList)
	dxUnselectAllRows(dxList)
end