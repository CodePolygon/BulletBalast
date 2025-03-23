shader_type canvas_item;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    vec4 bg_color = texture(SCREEN_TEXTURE, SCREEN_UV);

    // Change the blend mode here:
    COLOR = tex_color * bg_color; // Multiply blend mode
}
