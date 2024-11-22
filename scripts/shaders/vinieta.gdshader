shader_type canvas_item;

uniform float vignette_strength : hint_range(0.0, 1.0) = 0.5; // Fuerza del efecto de viñeta
uniform float vignette_radius : hint_range(0.0, 1.0) = 0.6; // Radio de la viñeta (cuánto de la pantalla se ve afectada)
uniform vec3 vignette_color = vec3(0.0, 0.0, 0.0); // Color de la viñeta (puedes ajustarlo a negro o un tono más suave)

void fragment() {
    // Obtener las coordenadas de píxel normalizadas
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE.xy;

    // Calcular la distancia del centro
    float dist = distance(uv, vec2(0.5, 0.5)); // Distancia desde el centro de la pantalla (0.5, 0.5)

    // Calcular el factor de viñeta en base a la distancia del centro
    float vignette = smoothstep(vignette_radius, vignette_radius - 0.1, dist);

    // Ajustar el color de la viñeta
    vec3 vignette_effect = mix(vec3(1.0), vignette_color, vignette * vignette_strength);

    // Obtener el color de la textura o fondo
    vec4 tex_color = texture(TEXTURE, UV);

    // Aplicar el efecto de viñeta al color final
    COLOR = vec4(tex_color.rgb * vignette_effect, tex_color.a);
}
