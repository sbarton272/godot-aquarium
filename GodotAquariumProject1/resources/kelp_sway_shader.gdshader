shader_type canvas_item;

uniform float sway_distance;

void vertex() {
	//print("Vertex {0}, {1}", VERTEX.x, VERTEX.y);
	if (VERTEX.y < 0.0) {
		VERTEX += vec2(sin(TIME * 0.5) * sway_distance,0);
	}
}
