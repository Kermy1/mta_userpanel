

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
function()	
	
end)

function loadVehicleLights(vehicle, lights)
	local texture = dxCreateTexture("lights/images/"..lights..".jpg","dxt3")
	local shader = dxCreateShader("lights/lights.fx")
	dxSetShaderValue(shader,"gTexture",texture)
	engineApplyShaderToWorldTexture(shader,"vehiclelights128",vehicle)
	engineApplyShaderToWorldTexture(shader,"vehiclelightson128",vehicle)
end