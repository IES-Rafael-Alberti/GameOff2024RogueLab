shader_type canvas_item;

uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.5; // Controla la intensidad de las líneas de escaneo
uniform float noise_intensity : hint_range(0.0, 1.0) = 0.2; // Controla la intensidad del ruido
uniform float distortion : hint_range(0.0, 0.1) = 0.05; // Controla la intensidad de la distorsión horizontal
uniform float time; // Tiempo, actualízalo desde el script para animar el ruido y la distorsión

void fragment() {
    // Obtiene las coordenadas UV y añade una distorsión en el eje X para el efecto de "curvatura" de pantalla
    vec2 uv = UV;
    uv.x += sin(uv.y * 3.1415) * distortion;

    // Obtiene el color de la textura en la posición distorsionada
    vec4 color = texture(TEXTURE, uv);
    
    // Añade un efecto de ruido en blanco y negro
    float noise = fract(sin(dot(uv * vec2(12.9898, 78.233) + time, vec2(43.2324, 24.431))) * 43758.5453);
    color.rgb += (noise - 0.5) * noise_intensity;

    // Aplica las líneas de escaneo: alterna el brillo de cada línea horizontal
    float scanline = sin(uv.y * 800.0) * 0.5 + 0.5;
    color.rgb *= mix(1.0, scanline, scanline_intensity);

    // Aplica el color final, manteniendo la transparencia original
    COLOR = vec4(color.rgb, color.a);
}
