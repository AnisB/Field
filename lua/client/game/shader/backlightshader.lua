--[[ 
This file is part of the Field project
]]

BackLightShader = {}
BackLightShader.__index = BackLightShader

function BackLightShader.new()
	local self = {}
	setmetatable(self, BackLightShader)
  self.isSupported=love.graphics.isSupported("canvas","pixeleffect")
  self:init()
  return self
end


function BackLightShader:init()
	local xf = love.graphics.newPixelEffect[[
   extern vec3 light_pos;
   extern float ao_toggle;

   vec3 dark_color = vec3(0.0, 0.0, 0.0);
   vec3 light_color = vec3(1, 1, 1);

   vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords) {

   // Récupération de la Diffuse
   vec4 diffuse  = Texel(texture, texture_coords);


   //Définition de la direction de la lumière
   vec3 light_direction = light_pos - vec3(pixel_coords, 0);

   // Récupération de la distance par rapport à l'objet (Norme du vecteur)
   float light_distance = length(light_direction);

   // Formule pour l'atténuation
   float attenuation = 70/sqrt(pow(light_distance, 2));

   // Norme du vecteur d'attenuation
   light_direction = normalize(light_direction);

   //Caulcul de la valeur de l'illumination pour un point donné
   float light = clamp(attenuation , 0.0, 1.0);

   // Ombrage
   float cel_light =smoothstep(0.30, 0.52, light)*0.6 + 0.4;

   return vec4(cel_light* diffuse.rgb, diffuse.a);
}
]]

self.xf = xf
self.time = 0
end
function BackLightShader:setParameter(p)
  if self.isSupported then
    for k,v in pairs(p) do
       self.xf:send(k,v)
    end
 end
end

function BackLightShader:update(dt)
   
end

function BackLightShader:predraw()
 if self.isSupported then
   love.graphics.setPixelEffect(self.xf)
end
end

function BackLightShader:postdraw()
 if self.isSupported then
   love.graphics.setPixelEffect()
end
end
