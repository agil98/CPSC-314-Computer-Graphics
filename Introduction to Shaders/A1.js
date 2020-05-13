/*
 * UBC CPSC 314, Vjan2019
 * Assignment 1 Template
 */

var bunnyPosition;
var bunnyPosition1;
var carrotPosition = new THREE.Vector3(0.0, 0.0, 0.0);
var stemPosition;
var bunny;
var rotationx = 0.0;
var rotationy = 0.0;
var rotationz = 0.0;

// CHECK WEBGL VERSION
if ( WEBGL.isWebGL2Available() === false ) {
  document.body.appendChild( WEBGL.getWebGL2ErrorMessage() );
}

// SETUP RENDERER & SCENE
var container = document.createElement( 'div' );
document.body.appendChild( container );

var canvas = document.createElement("canvas");
var context = canvas.getContext( 'webgl2' );
var renderer = new THREE.WebGLRenderer( { canvas: canvas, context: context } );
renderer.setClearColor(0XAFEEEE); // green background colour
container.appendChild( renderer.domElement );
var scene = new THREE.Scene();

// SETUP CAMERA
var camera = new THREE.PerspectiveCamera(30,1,0.1,1000); // view angle, aspect ratio, near, far
camera.position.set(45,20,40);
camera.lookAt(scene.position);
scene.add(camera);

// SETUP ORBIT CONTROLS OF THE CAMERA
var controls = new THREE.OrbitControls(camera);
controls.damping = 0.2;
controls.autoRotate = false;

// ADAPT TO WINDOW RESIZE
function resize() {
  renderer.setSize(window.innerWidth,window.innerHeight);
  camera.aspect = window.innerWidth/window.innerHeight;
  camera.updateProjectionMatrix();
}

// EVENT LISTENER RESIZE
window.addEventListener('resize',resize);
resize();

//SCROLLBAR FUNCTION DISABLE
window.onscroll = function () {
     window.scrollTo(0,0);
   }

// WORLD COORDINATE FRAME: other objects are defined with respect to it
var worldFrame = new THREE.AxesHelper(5) ;
scene.add(worldFrame);

// FLOOR WITH PATTERN
var floorTexture = new THREE.TextureLoader().load('images/floor.jpg');
floorTexture.wrapS = floorTexture.wrapT = THREE.RepeatWrapping;
floorTexture.repeat.set(2, 2);

var floorMaterial = new THREE.MeshBasicMaterial({ map: floorTexture, side: THREE.DoubleSide });
var floorGeometry = new THREE.PlaneBufferGeometry(30, 30);
var floor = new THREE.Mesh(floorGeometry, floorMaterial);
floor.position.y = -0.1;
floor.rotation.x = Math.PI / 2;
scene.add(floor);
floor.parent = worldFrame;

// UNIFORMS
var bunnyPosition = {type: 'v3', value: new THREE.Vector3(0.0,0.0,0.0)};
var bunnyPosition1 = {type: 'v3', value: new THREE.Vector3(0.0,0.0,0.0)};
var height = {type: 'v3', value: new THREE.Vector3(0.0,0.0,0.0)};
var height1 = {type: 'v3', value: new THREE.Vector3(0.0,0.0,0.0)};
var rotate = {type: 'v3', value: new THREE.Vector3(0.0,0.0,0.0)};


// MATERIALS: specifying uniforms and shaders
var bunnyMaterial = new THREE.ShaderMaterial({
  uniforms: { bunnyPosition: bunnyPosition, height:height, rotate: rotate,
  }
});

var bunnyMaterial1 = new THREE.ShaderMaterial({
  uniforms: { bunnyPosition1: bunnyPosition1, height1: height1,
  }
});

var eggMaterial = new THREE.ShaderMaterial({
  uniforms: { bunnyPosition: bunnyPosition,
  }
});

var carrotMaterial = new THREE.ShaderMaterial({
  uniforms: {bunnyPosition: bunnyPosition,bunnyPosition1 : bunnyPosition1,}
});

var stemMaterial = new THREE.ShaderMaterial({
  uniforms: {bunnyPosition: bunnyPosition, bunnyPosition1: bunnyPosition1,}
});


// LOAD SHADERS
var shaderFiles = [
  'glsl/bunny.vs.glsl',
  'glsl/bunny.fs.glsl',
  'glsl/bunny1.vs.glsl',
  'glsl/bunny1.fs.glsl',
  'glsl/egg.vs.glsl',
  'glsl/egg.fs.glsl',
  'glsl/carrot.vs.glsl',
  'glsl/carrot.fs.glsl',
  'glsl/stem.vs.glsl',
  'glsl/stem.fs.glsl',
];

new THREE.SourceLoader().load(shaderFiles, function(shaders) {
  bunnyMaterial.vertexShader = shaders['glsl/bunny.vs.glsl'];
  bunnyMaterial.fragmentShader = shaders['glsl/bunny.fs.glsl'];

  eggMaterial.vertexShader = shaders['glsl/egg.vs.glsl'];
  eggMaterial.fragmentShader = shaders['glsl/egg.fs.glsl'];

  carrotMaterial.vertexShader = shaders['glsl/carrot.vs.glsl'];
  carrotMaterial.fragmentShader = shaders['glsl/carrot.fs.glsl'];

  stemMaterial.vertexShader = shaders['glsl/stem.vs.glsl'];
  stemMaterial.fragmentShader = shaders['glsl/stem.fs.glsl'];

  bunnyMaterial1.vertexShader = shaders['glsl/bunny1.vs.glsl'];
  bunnyMaterial1.fragmentShader = shaders['glsl/bunny1.fs.glsl'];

})

var ctx = renderer.context;
ctx.getShaderInfoLog = function () { return '' };   // stops shader warnings, seen in some browsers

// LOAD BUNNY
function loadOBJ(file, material, scale, xOff, yOff, zOff, xRot, yRot, zRot) {
  var manager = new THREE.LoadingManager();
          manager.onProgress = function (item, loaded, total) {
    console.log( item, loaded, total );
  };

  var onProgress = function (xhr) {
    if ( xhr.lengthComputable ) {
      var percentComplete = xhr.loaded / xhr.total * 100;
      console.log( Math.round(percentComplete, 2) + '% downloaded' );
    }
  };

  var onError = function (xhr) {
  };

  var loader = new THREE.OBJLoader( manager );
  loader.load(file, function(object) {
    object.traverse(function(child) {
      if (child instanceof THREE.Mesh) {
        child.material = material;
      }
    });

    object.position.set(xOff,yOff,zOff);
    object.rotation.x= xRot;
    object.rotation.y = yRot;
    object.rotation.z = zRot;
    object.scale.set(scale,scale,scale);
    object.parent = worldFrame;
    bunny = object;
    scene.add(object);

  }, onProgress, onError);
}


loadOBJ('obj/bunny.obj', bunnyMaterial, 20, 0,-0.7,0, 0,0,0);
loadOBJ('obj/bunny.obj', bunnyMaterial1, 30, 0, -1.0,7, 0,0,0);

// CREATE EGG
var eggGeometry = new THREE.SphereGeometry(1, 32, 32);
var egg = new THREE.Mesh(eggGeometry, eggMaterial);
egg.position.set(5.0, 0.3, 5.0);
egg.scale.set(0.3, 0.4, 0.3);
egg.parent = worldFrame;
scene.add(egg);

var carrotGeometry = new THREE.ConeBufferGeometry(1, 2, 32);
var carrot = new THREE.Mesh( carrotGeometry, carrotMaterial );
carrot.rotation.x = Math.PI;
carrot.position.set(5.0, 0.9, 5.0);
carrot.parent = worldFrame;
scene.add( carrot );

var stemGeometry = new THREE.CylinderGeometry( 0.3, 0.3, 0.7, 32 );
var stem = new THREE.Mesh( stemGeometry, stemMaterial );
stem.position.set(5.0, 1.9, 5.0);
stem.parent = worldFrame;
scene.add( stem );

// LISTEN TO KEYBOARD
var keyboard = new THREEx.KeyboardState();
function checkKeyboard() {
  if (keyboard.pressed("W"))
    bunnyPosition.value.z -= 0.1;
  else if (keyboard.pressed("S"))
    bunnyPosition.value.z += 0.1;

  if (keyboard.pressed("A"))
    bunnyPosition.value.x -= 0.1;
  else if (keyboard.pressed("D"))
    bunnyPosition.value.x += 0.1;
  
    if (keyboard.pressed("Z")){
      height.value.x++;
    }

  if (keyboard.pressed("X")){
    var egg1 = new THREE.Mesh(eggGeometry, eggMaterial);
    egg1.position.set(bunnyPosition.value.x, 0.3, bunnyPosition.value.z);
    egg1.scale.set(0.3, 0.4, 0.3);
    egg1.parent = worldFrame;
    scene.add(egg1);
  }
  if (keyboard.pressed("N")){
    var carrot1 = new THREE.Mesh( carrotGeometry, carrotMaterial );
    var posx = Math.random() * 28.0 - 14.5;
    var posz = Math.random() * 28.0 - 14.5;
    carrot1.position.set(posx, 0.9, posz);
    carrot1.rotation.x = Math.PI;
    carrot1.parent = worldFrame;
    scene.add( carrot1 );

    var stem1 = new THREE.Mesh( stemGeometry, stemMaterial );
    stem1.position.set(posx, 1.9, posz);
    stem1.parent = worldFrame;
    scene.add( stem1 ); 
  }

  if(keyboard.pressed("R")){
    rotationy = 1.0;
    animate();
  }
  if (keyboard.pressed("I"))
    bunnyPosition1.value.z -= 0.1;
  else if (keyboard.pressed("K"))
    bunnyPosition1.value.z += 0.1;
  
  if (keyboard.pressed("J"))
    bunnyPosition1.value.x -= 0.1;
  else if (keyboard.pressed("L"))
    bunnyPosition1.value.x += 0.1;

  
    if (keyboard.pressed("M")){
      height1.value.x++;
    }


  bunnyMaterial.needsUpdate = true; 
  bunnyMaterial1.needsUpdate = true; 
  eggMaterial.needsUpdate = true;
  carrotMaterial.needsUpdate = true;
  stemMaterial.needsUpdate = true;
  rotate.value.x = 0.0;
  
}


// SETUP UPDATE CALL-BACK
function update() {
  checkKeyboard();
  requestAnimationFrame(update);
  renderer.render(scene, camera);
}

function animate() {
    bunny.rotation.y +=  0.005;
  requestAnimationFrame( animate );
  renderer.render( scene, camera );
}

update();

