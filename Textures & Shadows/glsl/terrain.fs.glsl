#version 300 es

out vec4 out_FragColor;

in vec3 vcsNormal;
in vec3 vcsPosition;
in vec2 vcsTexcoord;

uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightDirection;

uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

uniform sampler2D colorMap;
uniform sampler2D normalMap;
uniform sampler2D aoMap;
uniform sampler2D shadowMap;

in vec4 fragPosition;

in mat3 TBN;
in mat3 invTBN;

void main() {
	// TANGENT SPACE NORMAL
	vec3 Nt = normalize(texture(normalMap, vcsTexcoord).xyz * 2.0 - 1.0);
	
	// LIGHT SPACE 
	vec3 projCoords = fragPosition.xyz/ fragPosition.w;
	projCoords = projCoords * 0.5 + 0.5; 
	float closest = texture(shadowMap, projCoords.xy).r;
	float current = projCoords.z; 
	float bias = 0.0005;  
	float shadow = current - bias > closest  ? 1.0 : 0.0;  
	// PRE-CALCS
	vec3 Ni = normalize(invTBN * vcsNormal); // difference between Ni and Nt
	vec3 L = normalize(invTBN * vec3(viewMatrix * vec4(lightDirection, 0.0)));
	vec3 V = normalize(-(invTBN * vcsPosition));
	vec3 H = normalize((V + L) * 0.5);

	//AMBIENT
	vec3 light_AMB = ambientColor * kAmbient * vec3(texture(aoMap, vcsTexcoord));

	//DIFFUSE
	vec3 diffuse = kDiffuse * lightColor * vec3(texture(colorMap, vcsTexcoord));
	vec3 light_DFF = diffuse * max(0.0, dot(Nt, L));

	//SPECULAR
	vec3 specular = kSpecular * lightColor;
	vec3 light_SPC = specular * pow(max(0.0, dot(H, Nt)), shininess);

	//TOTAL
	vec3 TOTAL = light_AMB + ((1.0 - shadow) * (light_DFF  + light_SPC));

	out_FragColor = vec4(TOTAL, 1.0);
}
