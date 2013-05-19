--[[ 
This file is part of the Field project
]]

LightShader = {}
LightShader.__index = LightShader

  function LightShader.new()
   local self = {}
   setmetatable(self, LightShader)
   self.isSupported=love.graphics.isSupported("canvas","pixeleffect")
   self:init()
   return self
 end


function LightShader:init()
	local xf = love.graphics.newPixelEffect[[
extern vec3 light_pos;
extern float ao_toggle;

vec3 dark_color = vec3(0.0, 0.0, 0.0);
vec3 light_color = vec3(1, 1, 1);

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords) {

   // Récupération de la Diffuse
   vec4 diffuse  = Texel(texture, texture_coords);


   // Récupération de la deuxieme texture
   vec3 normal  = Texel(texture, texture_coords +vec2(0.51,0) ).rgb;
       // Inversion de l'axe Y
       normal.y = 1 - normal.y;


       normal = normalize(mix(vec3(-1), vec3(1), normal));


   //Définition de la direction de la lumière
   vec3 light_direction = light_pos - vec3(pixel_coords, 0);

   // Récupération de la distance par rapport à l'objet (Norme du vecteur)
   float light_distance = length(light_direction);

   // Formule pour l'atténuation
   float attenuation = 50000/(pow(light_distance, 2));

   // Norme du vecteur d'attenuation
   light_direction = normalize(light_direction);

   //Caulcul de la valeur de l'illumination pour un point donné
   float light = clamp(attenuation * dot(normal, light_direction), 0.0, 1.0);

   // Génération de la couleur pour le pixel donné
   vec3 brillance = mix(dark_color,light_color,light )* 0.10;

   // Ombrage
   float cel_light =smoothstep(0.30, 0.52, light)*0.6 + 0.4;

   return vec4(cel_light* diffuse.rgb * light_color, diffuse.a);
}
	]]
	
	self.xf = xf
end

  function LightShader:setParameter(p)
    -- if self.isSupported then
     for k,v in pairs(p) do
        self.xf:send(k,v)
    end
  -- end
  end

function LightShader:update(dt)

end

function LightShader:predraw()
  -- if self.isSupported then
   love.graphics.setPixelEffect(self.xf)
 -- end
end

function LightShader:postdraw()
  if self.isSupported then
   love.graphics.setPixelEffect()
 end
end
