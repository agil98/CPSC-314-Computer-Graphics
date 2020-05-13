#version 300 es

out vec3 vcsNormal;
out vec3 vcsPosition;
out vec2 vcsTexcoord;
vec3 tangent;
vec3 bitangent;
out mat3 TBN;
out mat3 invTBN;
uniform mat4 lightViewMatrixUniform;
uniform mat4 lightProjectMatrixUniform;
out vec4 fragPosition;

void main() {
	// viewing coordinate system
	vcsNormal = normalMatrix * normal;
	vcsPosition = vec3( modelViewMatrix * vec4(position, 1.0));
	vcsTexcoord = uv;
	tangent =  cross(vcsNormal, vec3(0.0, 1.0, 0.0));
	bitangent =  cross(tangent, vcsNormal);
	TBN = mat3(tangent, bitangent, vcsNormal);
	invTBN = transpose(TBN); // model space to tangent space
	fragPosition = 	lightProjectMatrixUniform * lightViewMatrixUniform * modelMatrix * vec4(position, 1.0);
  	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
