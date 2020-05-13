#version 300 es

out vec4 out_FragColor;
uniform vec3 lightColorUniform;
uniform vec3 lightDirectionUniform;
in vec4 n;
uniform vec3 kDiffuseUniform;
uniform vec3 ambientColorUniform;
uniform vec3 kAmbientUniform;
in vec3 camera;
in vec4 vposition;
uniform float shininessUniform;
void main() {


	//TOTAL INTENSITY
	float lightIntensity = 0.0;
	vec3 position = vec3(vposition);
	vec3 light_AMB = vec3(0.16, 0.16, 0.16);
	vec3 normal = normalize(vec3(n.x, n.y,n.z));
	//DIFFUSE
	vec3 light_DFF = vec3(0.8, 0.8, 0.8) * max(dot(normal, normalize(lightDirectionUniform)), 0.0); 
	//SPECULAR
	vec3 reflection = normalize(-lightDirectionUniform) - (2.0 * normal * dot(normal, normalize(-lightDirectionUniform)));
	vec3 eyeVector = normalize(camera);
	vec3 light_SPC = vec3(0.8,0.8,0.8) * pow(max( dot( eyeVector, reflection), 0.0), shininessUniform);
	lightIntensity = light_SPC.x + light_AMB.x + light_DFF.x;
	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
   	vec4 resultingColor = vec4(TOTAL, 1.0);

	if (lightIntensity > 0.75) 
		resultingColor = vec4(0.8,0.8,1.0,1.0);
	else if (lightIntensity > 0.50)
		resultingColor = vec4(0.6,0.6,0.8,1.0);
	else if (lightIntensity > 0.40)
		resultingColor = vec4(0.3,0.3,0.6,1.0);
	else if (lightIntensity > 0.20)
		resultingColor = vec4(0.2,0.2,0.4,1.0);
	else
		resultingColor = vec4(0.1,0.1,0.2,1.0);
		
	   vec3 view = camera - position;
 	if (dot(normal, view) <= 7.0)
		resultingColor = vec4(0.0, 0.0, 0.0, 1.0); 
	out_FragColor = resultingColor;
}
