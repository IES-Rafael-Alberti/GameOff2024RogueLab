shader_type canvas_item;

uniform float noise_intensity : hint_range(0.0, 1.0) = 0.1; // Intensidad del ruido
uniform vec3 paper_tint : hint_color = vec3(0.8, 0.75, 0.6); // Color base del papel (tono sepia)

void fragment() {
    // Obtén las coordenadas UV
    vec2 uv = UV;
    
    // Agrega una pequeña distorsión al patrón de píxeles para emular la textura de papel impreso
    vec2 paper_noise = fract(uv * 100.0);  // Este valor puede ajustarse para controlar el tamaño del patrón
    
    // Calcula el patrón de puntos (estilo de impresión de periódico)
    float pattern = step(0.5, sin(paper_noise.x * 3.1415) * sin(paper_noise.y * 3.1415));
    
    // Aplica el tinte sepia al color base
    vec3 color = paper_tint;
    
    // Agrega un poco de ruido para simular la calidad de impresión del periódico
    float noise = fract(sin(dot(uv * vec2(12.9898, 78.233), vec2(43.2324, 24.431))) * 43758.5453);
    noise = smoothstep(0.0, 1.0, noise) * noise_intensity;
    
    // Aplica el patrón y el ruido
    color *= mix(1.0, pattern, noise);  // Combina el color con el patrón de puntos y el ruido

    // Obtén el color original de la textura
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Combina el color de la textura con el efecto de periódico
    COLOR = vec4(color, tex_color.a);
}
