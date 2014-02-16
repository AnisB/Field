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