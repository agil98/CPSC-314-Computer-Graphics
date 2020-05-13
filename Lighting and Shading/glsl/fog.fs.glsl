#version 300 es
//in vec3 camera;
in vec4 vposition;
uniform float fogDensity;
uniform vec3 lightFogColorUniform;
uniform vec3 lightDirectionUniform;
out vec4 out_FragColor;
in vec4 n;
void main() {

	// TODO: PART 1C
	float FogLevel = 1.0/exp(length(vposition) * fogDensity);
	vec3 normal = normalize(vec3(n.x, n.y,n.z));
	vec3 light_DFF = vec3(0.8, 0.8, 0.8) * max(dot(normal, normalize(lightDirectionUniform)), 0.0); 
	out_FragColor = vec4(mix(lightFogColorUniform, light_DFF, FogLevel), 1.0);
}
