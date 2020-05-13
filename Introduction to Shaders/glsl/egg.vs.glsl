#version 300 es

out vec4 eggPosition;
void main() {


    eggPosition = modelMatrix * vec4( position, 1.0 );
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0 );

}