shader_type canvas_item;

uniform float blood_intensity : hint_range(0.0, 1.0) = 0.5; // Controla la intensidad del efecto de sangre
uniform float internal_limit : hint_range(0.0, 1.0) = 0.3; // Controla la intensidad del efecto de sangre
uniform float external_limit : hint_range(0.0, 1.0) = 0.6; // Controla la intensidad del efecto de sangre
//uniform float blood_intensity : hint_range(0.0, 1.0) = 0.5; // Controla la intensidad del efecto de sangre
uniform vec4 blood_color: source_color;

void fragment() {
    // Obtén las coordenadas UV actuales
    vec2 uv = UV;

    // Calcula la distancia desde el centro de la pantalla
    float dist_from_center = length(uv - vec2(0.5));

    // Define un tinte rojo con una transición suave hacia el centro
    float vignette = smoothstep(internal_limit, external_limit, dist_from_center);
    vec4 blood_tint = blood_color * vignette * blood_intensity;

    // Obtiene el color original de la textura en la posición actual
    vec4 color = texture(TEXTURE, UV);
	color.rgba = blood_tint;
    // Mezcla el color de la sangre con el color original
    color.rgba = mix(color.rgba, blood_tint, blood_intensity * vignette);
	//color.a = vignette * 0.7;
	//if(dist_from_center>0.4)
	//	color.a = blood_intensity;
    // Establece el color final
    COLOR = color;
}
