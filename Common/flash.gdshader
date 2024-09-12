shader_type canvas_item;

uniform vec4 flash_color : source_color;
uniform bool flash;
uniform vec4 base_color : source_color;
uniform vec4 outline_color : source_color;

void fragment() {
	if(flash){
		COLOR.rgb = flash_color.rgb;
	}
	else if(COLOR == vec4(0, 0, 0, 1)){
		COLOR.rgb = outline_color.rgb;
	}
	else if(COLOR == vec4(1, 1, 1, 1)){
		COLOR.rgb = base_color.rgb;
	}
}

