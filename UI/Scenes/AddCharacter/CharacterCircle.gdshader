shader_type canvas_item;

// Expose 'my_color' to the editor with default value of gray (r, g, b, alpha).
uniform vec4 color : source_color = vec4(.5, .5, .5, 1.0);
// This function is run on every pixel.
void fragment(){
    vec4 texture_color = texture(TEXTURE, UV);
    COLOR = texture_color * color;
}