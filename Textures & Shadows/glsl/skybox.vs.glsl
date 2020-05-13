#version 300 es
out vec3 coords;
void main() {
	coords = position;
	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}