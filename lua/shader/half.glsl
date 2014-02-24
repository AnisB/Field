

extern number vueP1;
extern float time;
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
{
	if(texture_coords.x<0.5)
	{

		if (vueP1 == 0)
		{
			if(texture_coords.y>0.25 && texture_coords.y<0.75)
				return Texel(texture, vec2((texture_coords.x+(1.0-time)*0.25)*(1.0*(time+1.0)),texture_coords.y*(1.0*(time+1.0))-0.5*time));
			else
				return vec4(0.0,0.0,0.0,1.0);
		}
		else if  (vueP1 == 1)
			if(texture_coords.y>0.25*(1.0-time) && texture_coords.y<(0.75*(1.0-time)+1))
				return Texel(texture, vec2((texture_coords.x+0.25*time)*(2.0-time),texture_coords.y*(2.0-time)-0.5*(1.0-time)));	
			else
				return vec4(0.0,0.0,0.0,1.0);
	}
	else
		return Texel(texture, vec2((texture_coords.x+0.25-0.5),texture_coords.y));
}