#version 300 es
out vec4 n;
out vec3 camera;
out vec4 vposition;
void main() {

    n =  inverse(viewMatrix) * vec4(normalMatrix * normal, 0.0);
    camera = cameraPosition;
    vposition = modelMatrix * vec4(position, 1.0);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}