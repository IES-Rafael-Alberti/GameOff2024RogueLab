shader_type canvas_item;

// Declarar un uniform para acceder a la textura de la pantalla
uniform sampler2D screen_texture : hint_screen_texture;

uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.5; // Controla la intensidad de las líneas de escaneo
uniform float noise_intensity : hint_range(0.0, 1.0) = 0.2; // Controla la intensidad del ruido
uniform float distortion : hint_range(0.0, 0.1) = 0.05; // Controla la intensidad de la distorsión horizontal
uniform float time; // Tiempo, actualízalo desde el script para animar el ruido y la distorsión

void fragment() {
    // Obtiene las coordenadas UV y añade una distorsión en el eje X para el efecto de "curvatura" de pantalla
    vec2 uv = UV;
    uv.x += sin(uv.y * 3.1415) * distortion;

    // Obtiene el color de la textura en la posición distorsionada
    vec4 tex_color = texture(TEXTURE, uv);

    // Obtiene el fondo de la pantalla utilizando el uniform screen_texture y las coordenadas SCREEN_UV
    vec4 screen_color = texture(screen_texture, SCREEN_UV);

    // Mezcla el color de la textura con el fondo basado en la transparencia de la textura
    vec4 final_color = mix(screen_color, tex_color, tex_color.a);

    // Añade un efecto de ruido en blanco y negro
    float noise = fract(sin(dot(uv * vec2(12.9898, 78.233) + time, vec2(43.2324, 24.431))) * 43758.5453);
    final_color.rgb += (noise - 0.5) * noise_intensity;

    // Aplica las líneas de escaneo: alterna el brillo de cada línea horizontal
    float scanline = sin(uv.y * 800.0) * 0.5 + 0.5;
    final_color.rgb *= mix(1.0, scanline, scanline_intensity);

    // Establece el color final con transparencia basada en la textura original
    COLOR = final_color;
}
