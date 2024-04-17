shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0);
uniform float width : hint_range(0, 100, 1.0) = 1.0;

void vertex() {
	VERTEX += (UV * 2.0 - 1.0) * width;
}

void fragment() {
	vec2 uv = UV;
	vec2 texture_pixel_size = vec2(1.0) / (vec2(1.0) / TEXTURE_PIXEL_SIZE + vec2(width * 2.0));
	
	//uv = (uv - texture_pixel_size * width) * TEXTURE_PIXEL_SIZE / texture_pixel_size;
	
	//if (UV.x < texture_pixel_size.x * width) {
		//discard;
	//}
	//float ratio = 0.125;
	vec2 ratio = vec2(width/1920.0, width/1080.0);
	if ((UV.x > ratio.x) && (UV.x < 1.0-ratio.x) && (UV.y > ratio.y) && (UV.y < 1.0-ratio.y)) {
		discard;
	}
}