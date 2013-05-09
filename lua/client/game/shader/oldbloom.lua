-- note that this might not be the most efficient way to blur,
-- a better way might be to scale down the canvases and
-- apply the final blur to the main canvas

BloomShaderEffect = {}
BloomShaderEffect.__index =  BloomShaderEffect

function BloomShaderEffect.new()
    local self = {}
    setmetatable(self, BloomShaderEffect)

	local xres, yres = 1280, 720

	
	self.blur_vertical = love.graphics.newPixelEffect[[
		extern number rt_h = 600.0; // render target height
		
		extern number intensity = 1.0;

		const number offset[3] = number[](0.0, 1.3846153846, 3.2307692308);
		const number weight[3] = number[](0.2270270270, 0.3162162162, 0.0702702703);
		
		vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
		{
			vec4 texcolor = Texel(texture, texture_coords);
			vec3 tc = texcolor.rgb * weight[0];
			
			tc += Texel(texture, texture_coords + intensity * vec2(0.0, offset[1])/rt_h).rgb * weight[1];
			tc += Texel(texture, texture_coords - intensity * vec2(0.0, offset[1])/rt_h).rgb * weight[1];
			
			tc += Texel(texture, texture_coords + intensity * vec2(0.0, offset[2])/rt_h).rgb * weight[2];
			tc += Texel(texture, texture_coords - intensity * vec2(0.0, offset[2])/rt_h).rgb * weight[2];
			
			return color * vec4(tc, texcolor.a);
		}
	]]
	self.blur_vertical:send("rt_h", yres)
	
	self.blur_horizontal = love.graphics.newPixelEffect[[
		extern number rt_w = 800.0; // render target width
		
		extern number intensity = 1.0;

		const number offset[3] = number[](0.0, 1.3846153846, 3.2307692308);
		const number weight[3] = number[](0.2270270270, 0.3162162162, 0.0702702703);

		vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
		{
			vec4 texcolor = Texel(texture, texture_coords);
			vec3 tc = texcolor.rgb * weight[0];
			
			tc += Texel(texture, texture_coords + intensity * vec2(offset[1], 0.0)/rt_w).rgb * weight[1];
			tc += Texel(texture, texture_coords - intensity * vec2(offset[1], 0.0)/rt_w).rgb * weight[1];
			
			tc += Texel(texture, texture_coords + intensity * vec2(offset[2], 0.0)/rt_w).rgb * weight[2];
			tc += Texel(texture, texture_coords - intensity * vec2(offset[2], 0.0)/rt_w).rgb * weight[2];
			
			return color * vec4(tc, texcolor.a);
		}
	]]
	self.blur_horizontal:send("rt_w", xres)
	
	self.canvases = {
		love.graphics.newCanvas(),
		love.graphics.newCanvas(),
	}
	self.time=0
		self.blur_vertical:send("intensity", (0.75))
	self.blur_horizontal:send("intensity", (0.75))
	return self
end


function BloomShaderEffect:update(dt)

end


function BloomShaderEffect:predraw()
	for i,v in ipairs(self.canvases) do v:clear() end
	
	love.graphics.setCanvas(self.canvases[1]) 
	end

function BloomShaderEffect:postdraw()

		love.graphics.setCanvas(self.canvases[2])
		love.graphics.setPixelEffect(self.blur_vertical)
		
		love.graphics.draw(self.canvases[1], 0, 0)
		
		love.graphics.setCanvas()
		love.graphics.setPixelEffect(self.blur_horizontal)
		
		love.graphics.draw(self.canvases[2], 0, 0)
		
		love.graphics.setPixelEffect()
end
