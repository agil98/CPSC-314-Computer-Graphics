#version 300 es
out vec3 camera;
out vec4 vposition;
out vec4 n;
void main() {

	// TODO: PART 1C
    n =  inverse(viewMatrix) * vec4(normalMatrix * normal, 0.0);
    //camera = cameraPosition;
    vposition =  viewMatrix * modelMatrix * vec4(position,1.0);
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position,1.0);
}
