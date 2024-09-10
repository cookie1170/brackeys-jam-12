shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
	
void fragment() {
	vec2 scrolling_uv_1 = UV + vec2(TIME * 0.1, 0);
	vec2 scrolling_uv_2 = UV - vec2(0, TIME * 0.1);
	vec4 mixed_noise = mix(texture(noise, scrolling_uv_1), texture(noise, scrolling_uv_2), 0.5);
	float two_color_noise = step(mixed_noise.r, 0.4) * 0.025;
	COLOR.rgb = vec3(two_color_noise) + vec3(0, 0, 0.05);
}

