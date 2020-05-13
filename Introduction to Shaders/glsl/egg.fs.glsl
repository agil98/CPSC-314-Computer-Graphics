#version 300 es

precision highp float;
precision highp int;
out vec4 out_FragColor; 
in vec4 eggPosition;
uniform vec3 bunnyPosition;

void main() {

  if (distance(vec3(eggPosition), bunnyPosition) < 4.0)
    out_FragColor = vec4(1.0, 0.0, 1.0, 1.0); 
  else 
    out_FragColor = vec4(1.0, 1.0, 1.0, 1.0);

}