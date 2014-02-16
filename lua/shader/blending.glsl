extern sampler2D filter;
extern float time;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
{
	vec4 image = Texel(texture, texture_coords);
	vec4 dis = Texel(filter, texture_coords);
	float T = clamp(time,0.0,0.5);
	return vec4(image.xyz+dis.xyz*dis.w*T,1.0);
}