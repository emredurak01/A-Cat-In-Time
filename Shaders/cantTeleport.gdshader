shader_type canvas_item;

uniform vec4 Color: source_color = vec4(1.0);

void fragment() {
	COLOR = Color;
}
