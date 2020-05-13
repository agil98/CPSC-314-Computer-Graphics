#version 300 es

out vec4 out_FragColor;
uniform samplerCube skybox;
in vec3 vcsNormal;
in vec3 vcsPosition;
in vec3 eyePosition;

uniform vec3 lightDirection;

void main( void ) {
vec3 reflection = normalize(reflect(vcsNormal, eyePosition));
out_FragColor = texture(skybox, reflection);
}
