#version 300 es
uniform vec3 armadilloPosition;
uniform vec3 eggPosition;
void main(){
    vec3 eggPosition1 = eggPosition;
    vec3 armadilloPosition1 = armadilloPosition;
    eggPosition1.x = 0.0;
    armadilloPosition1.x = 0.0;

    vec3 eyePosition = vec3(armadilloPosition.x, 2.42, -0.64);

    vec3 eyeToEgg = vec3(armadilloPosition.x + position.x, 2.42 , -0.64) - eggPosition;
    vec3 eggToEye = eggPosition - vec3(armadilloPosition.x + position.x, 2.42 , -0.64);

    float angle = acos(dot(vec2(eyeToEgg.x, eyeToEgg.z),-vec2(eggPosition.x, eggPosition.z))/((length(vec2(eyeToEgg.x, eyeToEgg.z)))*(length(vec2(eggPosition.x, eggPosition.z)))));

    // translate to the initial eye position
    mat4 T = mat4(vec4(1.0, 0.0 , 0.0, 0.0), vec4(0.0, 1.0 , 0.0, 0.0), vec4(0.0, 0.0 , 1.0, 0.0), vec4(-0.15, 2.42, -0.64, 1.0)); 
    
    // moves laser in response to the movement of the armadillo
    mat4 M = mat4(vec4(1.0, 0.0 , 0.0, 0.0), vec4(0.0, 1.0 , 0.0, 0.0), vec4(0.0, 0.0 , 1.0, 0.0), vec4(armadilloPosition[0], 0.0, 0.0, 1.0));

    // distance between the armadillo and the egg
    float D = length(eyePosition  - eggPosition); 

    // scaling vector
    mat4 S = mat4(1.0);
    S[1][1] = D;

    
    float angle1 = -acos(dot(vec3(0.0, 1.0, 0.0), eggToEye)/ (length(eggToEye)));

     if (armadilloPosition.x < 0.0){
      mat4 Rx = mat4(vec4(1.0,0.0,0.0,0.0), vec4(0.0, cos(angle1), sin(angle1), 0.0), vec4(0.0,-sin(angle1), cos(angle1), 0.0), vec4(0.0,0.0,0.0,1.0));
      mat4 Ry = mat4(vec4(cos(angle), 0.0, sin(angle), 0.0), vec4(0.0,1.0,0.0,0.0), vec4(-sin(angle), 0.0, cos(angle), 0.0), vec4(0.0,0.0,0.0,1.0));
      gl_Position = projectionMatrix * viewMatrix  * M * T * Ry * Rx  * S *  vec4(position, 1.0);
    }
    else{
      mat4 Rx = mat4(vec4(1.0,0.0,0.0,0.0), vec4(0.0, cos(angle1), sin(angle1), 0.0), vec4(0.0,-sin(angle1), cos(angle1), 0.0), vec4(0.0,0.0,0.0,1.0));
      mat4 Ry = mat4(vec4(cos(angle), 0.0, -sin(angle), 0.0), vec4(0.0,1.0,0.0,0.0), vec4(sin(angle), 0.0, cos(angle), 0.0), vec4(0.0,0.0,0.0,1.0));
      gl_Position = projectionMatrix * viewMatrix  * M * T * Ry * Rx  * S *  vec4(position, 1.0);
    }  
    // T R T_inv 

}