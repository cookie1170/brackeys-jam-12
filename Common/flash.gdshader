shader_type canvas_item;

uniform vec4 flash_color : source_color;
uniform bool flash;

void fragment() {
	if(flash){
		COLOR.rgb = flash_color.rgb;
	}
}

