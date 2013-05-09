--[[ 
This file is part of the Field project
]]

LightShader = {}
LightShader.__index = LightShader

function LightShader.new()
	local self = {}
	setmetatable(self, LightShader)
	self:init()
	return self
end


function LightShader:init()
	local xf = love.graphics.newPixelEffect[[
	extern vec3 light_vec;
	
	vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
	{
	vec3 light_direction = light_vec - vec3(pixel_coords, 0);
	float distance = length(light_direction);
	light_direction = normalize(light_direction);
	
	vec3 normal = Texel(texture, texture_coords).xyz;
	normal.y = 1 - normal.y;
	
	float attenuation = 50000/pow(distance, 2);
	
	float diffuse_term = clamp(attenuation * dot(normal, light_direction), 0.0, 1.0);
	
	
	float cel_diffuse_term = step(0.5, diffuse_term)/2 + 0.5;
	
	return vec4((cel_diffuse_term * Texel(texture, texture_coords).rgb), Texel(texture, texture_coords).a);
	}
	]]
	
	self.xf = xf
	self.time = 0
end

function LightShader:setParameter(p)
	for k,v in pairs(p) do
		self.xf:send(k,v)
	end
end

function LightShader:update(dt)

end

function LightShader:predraw()
	love.graphics.setPixelEffect(self.xf)
end

function LightShader:postdraw()
	love.graphics.setPixelEffect()
end
