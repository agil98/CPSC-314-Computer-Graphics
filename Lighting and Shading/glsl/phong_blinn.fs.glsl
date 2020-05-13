#version 300 es
uniform vec3 lightColorUniform;
uniform vec3 lightDirectionUniform;
out vec4 out_FragColor;
in vec4 n;
uniform vec3 kDiffuseUniform;
uniform vec3 ambientColorUniform;
uniform vec3 kAmbientUniform;
in vec4 vposition;
in vec3 camera;
uniform float shininessUniform;

void main() {
	//TODO: PART 1A
	vec3 position = normalize(camera - vec3(vposition));
		//AMBIENT
	vec3 light_AMB = vec3(0.16, 0.16, 0.16);
	vec3 normal = normalize(vec3(n.x, n.y,n.z));
	//DIFFUSE
	vec3 light_DFF = vec3(0.8, 0.8, 0.8) * max(dot(normal, normalize(lightDirectionUniform)), 0.0); 
	//SPECULAR
	vec3 halfVector = normalize(lightDirectionUniform + position);
	vec3 light_SPC = vec3(0.8,0.8,0.8) * pow(max( dot( normal, halfVector), 0.0), shininessUniform);
	
	//TOTAL
	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	out_FragColor = vec4(TOTAL, 1.0);
	}