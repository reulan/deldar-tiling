shader_type canvas_item;

uniform float scroll_speed : hint_range(0, 2) = 0.15;
uniform float angle : hint_range(0, 360, 1) = 10;
uniform float repeat_x : hint_range(0, 20, 1) = 3;
uniform float repeat_y : hint_range(0, 20, 1) = 3;
uniform float intensity: hint_range(0., 1.) = 0.05;

// Color

uniform float alpha : hint_range(0.0, 2.0) = 1.0;
uniform float radian_mod1 = 120.0;
uniform float radian_mod2 = 240.0;

void fragment() {
	// Scrolling
	float angle_radians = radians(angle);
	vec2 direction = vec2(cos(angle_radians), sin(angle_radians));
	vec2 offset = UV - (TIME * scroll_speed * direction);

	vec2 scaled_uv = vec2(fract(offset.x * repeat_x), fract(offset.y * repeat_y));
	vec2 texture_size = vec2(1.0) / vec2(textureSize(TEXTURE, 0));
	vec2 snapped_uv = round(scaled_uv / texture_size) * texture_size;

	// Get Random Color
	vec4 animated_line_color = vec4(
		0.5 + sin(2.0 * PI * intensity * TIME),
		0.5 + sin(2.0 * PI * intensity * TIME + radians(radian_mod1)),
		0.5 + sin(2.0 * PI * intensity * TIME + radians(radian_mod2)),
		alpha);

	COLOR = texture(TEXTURE, snapped_uv) * animated_line_color;
}