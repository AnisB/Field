

extern number vueP1;
extern number vueP2;
extern float time;
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
{
	if(texture_coords.x<0.5)
	{

		if (vueP1 == 0)
		{
			float x = texture_coords.x+(1.0-time)*0.25+texture_coords.x*time;
			float y = texture_coords.y + texture_coords.y*time-0.5*time;
			if(x>0.0 && x<1.0 && y>0.0 && y<1.0)
				return Texel(texture, vec2(x,y))*vec4(1.0,0.7,0.7,1.0);
			else
				return vec4(0.0,0.0,0.0,1.0);
		}
		else if  (vueP1 == 1)
		{
			float x = (texture_coords.x+0.25*time)+(1.0-time)*texture_coords.x;
			float y = texture_coords.y + texture_coords.y*(1.0-time) - 0.5*(1.0-time);	
			if(x>0.0 && x<1.0 && y>0.0 && y<1.0)
				return Texel(texture, vec2(x,y))*vec4(1.0,0.7,0.7,1.0);
			else
				return vec4(0.0,0.0,0.0,1.0);			
		}

	}
	else
		return Texel(texture, vec2((texture_coords.x+0.25-0.5),texture_coords.y));
}