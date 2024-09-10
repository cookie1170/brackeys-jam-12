shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform vec3 bgcolor;
uniform float stepamount : hint_range(0.0, 1.0, 0.05);

void fragment() {
	vec2 scrolling_uv_1 = UV + vec2(TIME * 0.02, 0);
	vec2 scrolling_uv_2 = UV - vec2(0, TIME * 0.02);
	vec4 mixed_noise = mix(texture(noise, scrolling_uv_1), texture(noise, scrolling_uv_2), 0.5);
	float two_color_noise = step(mixed_noise.r, stepamount) * 0.035;
	COLOR.rgb = vec3(two_color_noise) + (bgcolor.rgb);
}

