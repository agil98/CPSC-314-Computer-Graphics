#version 300 es

uniform vec3 bunnyPosition1;
uniform vec3 height1;
out vec3 interpolatedNormal;

void main() {
    interpolatedNormal = normal;


    vec4 a = vec4(1.0, 0.0, 0.0, 0.0);
    vec4 b = vec4(0.0, 1.0, 0.0, 0.0);
    vec4 c = vec4(0.0, 0.0, 1.0, 0.0);
    vec4 d = vec4(bunnyPosition1[0], (sin(height1[0]*0.10)*4.0)* (sin(height1[0]*0.10)*4.0), bunnyPosition1[2], 1.0);
    mat4 translation = mat4(a, b, c, d);
    gl_Position = projectionMatrix * viewMatrix * translation  * modelMatrix *  vec4(position, 1.0)  ; 


}