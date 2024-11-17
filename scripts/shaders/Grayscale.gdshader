shader_type canvas_item;

uniform float grayscaleIntesity = 1.0;

void fragment() {
	
	float grayscale = (COLOR.r + COLOR.g + COLOR.b) / 3.0 * grayscaleIntesity;
	
	COLOR = vec4(grayscale, grayscale, grayscale, COLOR.a);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
