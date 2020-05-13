#version 300 es

precision highp float;
precision highp int;
out vec4 out_FragColor; 
uniform vec3 bunnyPosition;
uniform vec3 bunnyPosition1;
in vec4 stemPosition;

void main() {
    if (distance(vec3(stemPosition), bunnyPosition) < 4.0)
        out_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    else 
        out_FragColor = vec4(0.0, 1.0, 0.0, 1.0);

}
