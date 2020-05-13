#version 300 es

precision highp float;
precision highp int;
out vec4 out_FragColor;

in vec3 interpolatedNormal;
void main() {
  
  out_FragColor = vec4(normalize(interpolatedNormal), 1.0); 
  
}