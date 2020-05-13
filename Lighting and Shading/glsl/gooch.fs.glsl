#version 300 es
uniform vec3 lightColorUniform;
uniform vec3 lightDirectionUniform;
out vec4 out_FragColor;
in vec4 n;
in vec3 camera;
in vec4 vposition;
uniform float shininessUniform;

void main() {
	vec3 position = vec3(vposition);
	vec3 normal = normalize(vec3(n));
	float alpha = 0.3; // diffuse for the cool colour
	float beta = 0.3; //diffuse for the warm colour
	vec3 kblue = vec3(0.0, 0.0, 0.8);
	vec3 kyellow = vec3(1.0, 1.0, 0.0);
	vec3 kcool = min(kblue + alpha * lightColorUniform, 1.0);
 	vec3 kwarm = min(kyellow + beta * lightColorUniform, 1.0);
	float weight = 0.5 * (1.0 + dot(normalize(normal), normalize(lightDirectionUniform)));
	vec3 reflection = normalize(-lightDirectionUniform) + (2.0 * normal * dot(normal, normalize(lightDirectionUniform)));
	vec3 eyeVector = normalize(camera);
	vec3 light_SPC = vec3(0.8,0.8,0.8) * pow(max( dot( eyeVector, reflection), 0.0), shininessUniform);
	 vec3 view = camera - position;
 	if (dot(normal, view) <= 7.0)
		out_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
	else{
		vec3 colour = mix(kcool, kwarm, weight) + light_SPC;
		out_FragColor = vec4(colour, 1.0);
	}
	
}