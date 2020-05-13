#version 300 es
out vec4 vposition;
out vec4 n;
out vec3 camera;
void main() {

	// TODO: PART 1C
    camera = cameraPosition;
    n =  inverse(viewMatrix) * vec4(normalMatrix * normal, 0.0);
    vposition = modelMatrix * vec4(position,1.0);
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position,1.0);
}
