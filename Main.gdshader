shader_type canvas_item;

uniform float vignette_intensity : hint_range(0.0, 1.0) = 0.5;
uniform float vignette_opacity : hint_range(0.0, 1.0) = 0.5;

void fragment() {
    vec2 uv = UV;
    uv *= 1.0 - uv.yx; // Multiply by inverted coordinates

    float vig = uv.x * uv.y * 15.0; // Adjust multiplier for size
    vig = pow(vig, vignette_intensity); // Control falloff

    COLOR = vec4(0.0, 0.0, 0.0, (1.0 - vig) * vignette_opacity);
}