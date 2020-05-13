#version 300 es

out vec4 out_FragColor;

uniform samplerCube skybox;
in vec3 coords;
void main() {
	out_FragColor = texture(skybox, coords);
	//out_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
}