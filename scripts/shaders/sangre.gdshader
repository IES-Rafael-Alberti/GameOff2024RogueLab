shader_type canvas_item;

uniform float blood_intensity : hint_range(0.0, 1.0) = 0.5; // Controla la intensidad del efecto de sangre

void fragment() {
    // Obtén las coordenadas UV actuales
    vec2 uv = UV;

    // Calcula la distancia desde el centro de la pantalla
    float dist_from_center = length(uv - vec2(0.5));

    // Define un tinte rojo con una transición suave hacia el centro
    float vignette = smoothstep(0.2, 0.5, dist_from_center);
    vec3 blood_tint = vec3(0.5, 0.0, 0.0) * vignette * blood_intensity;

    // Obtiene el color original de la textura en la posición actual
    vec4 color = texture(TEXTURE, UV);

    // Mezcla el color de la sangre con el color original
    color.rgb = mix(color.rgb, blood_tint, blood_intensity * vignette);

    // Establece el color final
    COLOR = color;
}
