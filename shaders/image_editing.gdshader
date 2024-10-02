shader_type canvas_item;

uniform vec4 modulate: source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float saturation: hint_range(0.0, 2.0) = 1.0;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	
	vec4 pixel_color = vec4(
		texture_color.r * modulate.r,
		texture_color.g * modulate.g,
		texture_color.b * modulate.b,
		texture_color.a
	);
	
	float gray = (0.299 * texture_color.r + 0.587 * texture_color.g + 0.114 * texture_color.b);
	
	pixel_color.rgb = mix(vec3(gray), pixel_color.rgb, saturation);
	
	COLOR = pixel_color;
}
