shader_type canvas_item;

uniform vec2 center; // Center position in normalized coordinates (0-1)
uniform float diameter_factor; // This factor will control the proportion of the radius to the screen size
uniform float softness;
uniform vec4 vignette_color : source_color; // Color outside the circle

void fragment() {
    // Calculate the radius based on the screen size and the factor
    float radius = length(1.0/SCREEN_PIXEL_SIZE) * diameter_factor / 2.0;

    // Calculate the distance from the current pixel to the center
    float distance = distance(center * 1.0/SCREEN_PIXEL_SIZE, FRAGCOORD.xy);

    // Calculate the vignette intensity based on the distance and radius
    float vignette_intensity = smoothstep(radius, radius - softness, distance);

    // Calculate the transparency for the circle
    float circle_transparency = smoothstep(radius - softness, radius, distance);

    // Make the content inside the circle transparent
    vec4 content_color = texture(TEXTURE, UV);
    content_color.a *= circle_transparency;

    // Blend the content color with the vignette color
    COLOR = vec4(vignette_color.rgb, circle_transparency);
}