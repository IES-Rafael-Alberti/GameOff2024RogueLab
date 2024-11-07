shader_type canvas_item;

uniform float darkness = 0.5; // Controla la intensidad del oscurecimiento
uniform vec4 tint_color = vec4(0.0, 0.1, 0.2, 1.0); // Color azulado oscuro con opacidad completa

void fragment() {
    // Obtiene el color original de la textura en la posición actual
    vec4 color = texture(TEXTURE, UV);
    
    // Mezcla el color original con el color de tinte azul oscuro, basado en la intensidad de oscuridad
    vec3 darkened_color = mix(color.rgb, tint_color.rgb, darkness);
    
    // Aplica el color final con el efecto oscuro y azulado, manteniendo la transparencia original
    COLOR = vec4(darkened_color, color.a);
}
