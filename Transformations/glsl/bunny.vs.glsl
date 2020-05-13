#version 300 es

// Create shared variable for the vertex and fragment shaders
out vec3 interpolatedNormal;
out float intensity;

uniform vec3 bunnyPosition;
uniform vec3 lightPosition;
uniform vec3 armadilloPosition;

void main() {
    // Calculate position in world coordinates
    vec4 wpos = modelMatrix * vec4(position, 1.0) + vec4(bunnyPosition, 0.0);

    // Calculates vector from the vertex to the light
    vec3 l = lightPosition - wpos.xyz;

    // Calculates the intensity of the light on the vertex
    intensity = dot(normalize(l), normal);

    // Use normal as the color, pass is to fragment shader
    interpolatedNormal = normal;

    // Scale matrix
    mat4 S = mat4(10.0);
    S[3][3] = 1.0;

    vec3 bunnyPosition1 = bunnyPosition;
    vec3 armadilloPosition1 = armadilloPosition;
    bunnyPosition1[1] = 0.0;
    armadilloPosition1[1] = 0.0;


    /* You need to calculate rotation matrix here */
    float angle = acos(dot(-bunnyPosition1, armadilloPosition1 - bunnyPosition1)/ (length(armadilloPosition1 - bunnyPosition1)*length(bunnyPosition1)));

    // Translation matrix
    mat4 T = mat4(1.0);
    T[3].xyz = bunnyPosition;

    if (armadilloPosition.x < 0.0){
      mat4 R = mat4(vec4(cos(angle), 0, sin(angle), 0), vec4(0,1,0,0), vec4(-sin(angle), 0, cos(angle), 0), vec4(0,0,0,1));
      gl_Position = projectionMatrix * viewMatrix * T * R * S * vec4(position, 1.0);
    }
    else{
      mat4 R = mat4(vec4(cos(angle), 0, -sin(angle), 0), vec4(0,1,0,0), vec4(sin(angle), 0, cos(angle), 0), vec4(0,0,0,1));
      gl_Position = projectionMatrix * viewMatrix * T * R * S * vec4(position, 1.0);
    }
}
