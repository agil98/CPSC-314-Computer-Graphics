#version 300 es

precision highp float;
precision highp int;
out vec4 out_FragColor;

in vec3 interpolatedNormal;
void main() {
  vec3 a = vec3(1.0, 0.0, 1.0);
  vec3 b = vec3(1.0, 1.0, 0.0);
  vec3 c = vec3(1.0, 1.0, 1.0);
  mat3 translation = mat3(a, b, c);

  out_FragColor = vec4(normalize(interpolatedNormal * translation), 1.0); 
  
}