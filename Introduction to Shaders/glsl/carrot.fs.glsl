#version 300 es

precision highp float;
precision highp int;
out vec4 out_FragColor; 
in vec4 carrotPosition;
uniform vec3 bunnyPosition;
uniform vec3 bunnyPosition1;

void main() {
  if (distance(vec3(carrotPosition), bunnyPosition) < 4.0)
    out_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
else
    out_FragColor = vec4(1.0, 0.5, 0.0, 1.0);

}