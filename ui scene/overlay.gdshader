shader_type canvas_item;

uniform sampler2D screen_texture; // Manual screen texture
uniform float noise_strength : hint_range(0.0, 1.0) = 0.3;
uniform float noise_scale : hint_range(1.0, 10.0) = 5.0;
uniform float time_speed : hint_range(0.0, 5.0) = 1.0;

float random(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    // Get the original screen color
    vec4 scene_color = texture(screen_texture, SCREEN_UV);

    // Generate procedural noise
    float noise = random(UV * noise_scale + TIME * time_speed);

    // Blend noise with the scene
    float noise_effect = mix(scene_color.r, noise, noise_strength);

    COLOR = vec4(vec3(noise_effect), scene_color.a);
}
