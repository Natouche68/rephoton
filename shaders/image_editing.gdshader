shader_type canvas_item;

uniform vec4 modulate: source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float saturation: hint_range(0.0, 2.0) = 1.0;
uniform float contrast: hint_range(-1.0, 1.0) = 0.0;
uniform float vignette: hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);
	
	// Modulate (warmth + tint)
	pixel_color = vec4(
		pixel_color.r * modulate.r,
		pixel_color.g * modulate.g,
		pixel_color.b * modulate.b,
		pixel_color.a
	);
	
	// Contrast
	pixel_color = vec4(
		pixel_color.r * (1.0 + contrast * 0.4) - contrast * 0.2,
		pixel_color.g * (1.0 + contrast * 0.4) - contrast * 0.2,
		pixel_color.b * (1.0 + contrast * 0.4) - contrast * 0.2,
		pixel_color.a
	);
	
	// Saturation (grayscale)
	float gray = (0.299 * pixel_color.r + 0.587 * pixel_color.g + 0.114 * pixel_color.b);
	pixel_color.rgb = mix(vec3(gray), pixel_color.rgb, saturation);
	
	// Vignette
	float distance_from_center = sqrt(pow(UV.x - 0.5, 2) + pow(UV.y - 0.5, 2));
	float vignette_intensity = vignette * pow(sin(distance_from_center * 2.0), 2);
	//float vignette_intensity = vignette * distance_from_center;
	pixel_color.rgb = mix(pixel_color.rgb, vec3(0.0), vignette_intensity);
	
	// Apply color
	COLOR = pixel_color;
}
