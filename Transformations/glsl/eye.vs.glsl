
out vec3 color;
uniform vec3 offset;
uniform vec3 armadilloPosition;
uniform vec3 eggPosition;

#define MAX_EYE_DEPTH 0.05

void main() {
  // simple way to color the pupil where there is a concavity in the sphere
  float d = min(1.0 - length(position), MAX_EYE_DEPTH);
  color = mix(vec3(1.0), vec3(0.0), d * 1.0 / MAX_EYE_DEPTH);

  mat4 S = mat4(0.1);
  S[3][3] = 1.0;

  /* YOUR CODES HERE: move and rotate eyes corresponding to the movement of armadillo */

  mat4 T = mat4(1.0);
  T[3][0] = offset[0] + armadilloPosition[0];
  T[3][1] = offset[1];
  T[3][2] = offset[2];

float angle = acos(dot(-eggPosition, armadilloPosition - eggPosition)/ (length(armadilloPosition - eggPosition)*length(eggPosition)));
mat4 R_2 = mat4(vec4(1.0,0.0,0.0,0.0), vec4(0.0, 0.0, -1.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), vec4(0.0,0.0,0.0,1.0));

    if (armadilloPosition.x < 0.0){
      mat4 R_1 = mat4(vec4(cos(angle), 0, sin(angle), 0), vec4(0,1,0,0), vec4(-sin(angle), 0, cos(angle), 0), vec4(0,0,0,1));
      gl_Position = projectionMatrix * viewMatrix * T * R_1 * R_2 * S * vec4(position, 1.0);
    }
    else{
      mat4 R_1 = mat4(vec4(cos(angle), 0, -sin(angle), 0), vec4(0,1,0,0), vec4(sin(angle), 0, cos(angle), 0), vec4(0,0,0,1));
      gl_Position = projectionMatrix * viewMatrix * T * R_1 * R_2 * S * vec4(position, 1.0);
    }
  // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
  //gl_Position = projectionMatrix * viewMatrix * T * R_1 *  R_2 * S * vec4(position, 1.0);
}
