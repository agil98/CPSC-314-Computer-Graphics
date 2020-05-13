#version 300 es
out vec4 n;
out vec3 camera;
void main() {

    // TODO: PART 1A
    n =  inverse(viewMatrix) * vec4(normalMatrix * normal, 0.0);
    camera = cameraPosition;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}