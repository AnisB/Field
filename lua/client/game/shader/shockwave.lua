--[[ 
This file is part of the Field project
]]

ShockwaveEffect = {}
ShockwaveEffect.__index = ShockwaveEffect

function ShockwaveEffect.new()
	local self = {}
	setmetatable(self, ShockwaveEffect)
	if not love.graphics.newPixelEffect
		or not love.graphics.isSupported
		or not love.graphics.isSupported("pixeleffect")
		or not love.graphics.isSupported("canvas") then
		self.isSupported=false
		return self
	end
	self.isSupported=true
	self:init()
	return self
end


function ShockwaveEffect:init()
	local xf = love.graphics.newPixelEffect[[
	extern vec2 center; // Centre de l'onde
	extern number time; // Temps
	extern vec3 shockParams; // 100.0, 8, 100

	vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
	{

	// Calcul de la distance par rapport au centre
	number dis = distance(texture_coords,center);

	// Si on est au centre dans la zone de propagation
	if ((dis <= (time + shockParams.z)) &&
		(dis >= (time - shockParams.z)))
{
	// Calcul de la distance par rapport au centre
	number diff = (dis - time);
	// Calcul de la modification
	number powDiff = 1.0 - pow(abs(diff*shockParams.x),shockParams.y);

	// Decalage temportel donc
	number diffTime = diff * powDiff;

	// Calcul du décalave UV
	vec2 diffUV = normalize(texture_coords - center);

	// Nouvelle texture
	texture_coords=texture_coords + diffUV * diffTime;
}

return Texel(texture, texture_coords);
}
]]

self.xf = xf
self.time = 0
end

function ShockwaveEffect:setParameter(p)
	if self.isSupported then
		for k,v in pairs(p) do
			self.xf:send(k,v)
		end
	end
end
function ShockwaveEffect:update(dt)
	if self.isSupported then
		self.time = self.time + dt
		self.xf:send("time",self.time)
	end
end
function ShockwaveEffect:predraw()
	if self.isSupported then
		self.prev=love.graphics.getPixelEffect()
		love.graphics.setPixelEffect(self.xf)
	end
end

function ShockwaveEffect:postdraw()
	if self.isSupported then
		if(self.prev~=nil) then
			love.graphics.setPixelEffect(self.prev)
		end
	end
end
