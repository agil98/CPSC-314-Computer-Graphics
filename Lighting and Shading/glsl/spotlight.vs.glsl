#version 300 es
out vec4 floorPosition;
void main() {

 	// TODO: PART 1D
  floorPosition = modelMatrix * vec4(position, 1.0);
  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}