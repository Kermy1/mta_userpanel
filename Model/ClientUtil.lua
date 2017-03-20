screenWidth,screenHeight = guiGetScreenSize()
centerWidth = screenWidth/2
centerHeight = screenHeight/2
heightScale = screenHeight/1080
widthScale = screenWidth/1920

localPlayer = getLocalPlayer()



function getFontSize(text, width, height)
	local bool = true
	local tempHeight = height
	while bool do
		local fontSize = dxGetFontSizeFromHeight(tempHeight, "default")
		if dxGetTextWidth(text, fontSize, "default") < width then
			return fontSize
		else
			tempHeight = tempHeight - 5
			if tempHeight <= 0 then
				return 0
			end
		end
	end
end

function dxGetFontSizeFromHeight(height, font)
    if type( height ) ~= "number" then return false end
    font = font or "default"
    local ch = dxGetFontHeight( 1, font )
    return height/ch
end

function dxDrawBorderedRectangle( x, y, width, height, color1, color2, _width, postGUI )
    local _width = _width or 1
    dxDrawRectangle ( x+1, y+1, width-1, height-1, color1, postGUI )
    dxDrawLine ( x, y, x+width, y, color2, _width, postGUI ) -- Top
    dxDrawLine ( x, y, x, y+height, color2, _width, postGUI ) -- Left
    dxDrawLine ( x, y+height, x+width, y+height, color2, _width, postGUI ) -- Bottom
    dxDrawLine ( x+width, y, x+width, y+height, color2, _width, postGUI ) -- Right
end

function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end


function isMouseInRec(x2,y2,w2,h2)
	if isCursorShowing() then
		local mouseX, mouseY = getCursorPosition()
		mouseX = mouseX*screenWidth
		mouseY = mouseY*screenHeight
		
		if mouseX > x2 and mouseX < x2+w2 and mouseY > y2 and mouseY < y2+h2 then
			return true
		else
			return false
		end
	else
		return false
	end
end

