shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0);
uniform vec2 size = vec2(1920, 1080);
uniform float width : hint_range(0, 100, 1.0) = 1.0;

void vertex() {
	VERTEX += (UV * 2.0 - 1.0) * width;
}

void fragment() {
	vec2 uv = UV;
	
	vec2 ratio = vec2(width/size.x, width/size.y);
	if ((UV.x > ratio.x) && (UV.x < 1.0-ratio.x) && (UV.y > ratio.y) && (UV.y < 1.0-ratio.y)) {
		discard;
	}
	COLOR = color;
}