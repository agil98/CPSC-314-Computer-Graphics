#version 300 es

precision highp float;
precision highp int;
 uniform vec3 spotlightPosition;
uniform vec3 spotDirectPosition;
out vec4 out_FragColor;
in vec4 floorPosition;

void main() {

	// TODO: PART 1D
    vec3 light = vec3(floorPosition) - spotlightPosition;
    //vec3 spot = spotDirectPosition - spotlightPosition;
    float cosTheta = dot(normalize(spotDirectPosition), normalize(light));
    float angle = 1.0/ sqrt(2.0);
     if (cosTheta <angle)
        out_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
     else {
        float spotExponent = 5.0;

        vec3 SpotColor = vec3(1.0, 1.0, 0.0);

        out_FragColor = vec4(SpotColor * pow(cosTheta, spotExponent), 1.0);
    }  
   // out_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
}