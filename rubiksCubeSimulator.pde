import peasy.*;

final color[] colors = {
  //Yellow Red Green
  #FFFF00, #FF0000, #00FF00, 
  //White Orange Blue
  #FFFFFF, #FFA500, #0000FF 
};

final int scale = 60;

final PVector[] axises = {
  new PVector(1, 0, 0), 
  new PVector(0, 1, 0), 
  new PVector(0, 0, 1)
};

PMatrix3D getRotation(int axis, int direction) {
  switch(axis) {
  case 0:
    return new PMatrix3D(
      1, 0, 0, 0, 
      0, cos(HALF_PI*direction), -sin(HALF_PI*direction), 0, 
      0, sin(HALF_PI*direction), cos(HALF_PI*direction), 0, 
      0, 0, 0, 1
      );
  case 1:
    return new PMatrix3D(
      cos(HALF_PI*direction), 0, sin(HALF_PI*direction), 0, 
      0, 1, 0, 0, 
      -sin(HALF_PI*direction), 0, cos(HALF_PI*direction), 0, 
      0, 0, 0, 1
      );
  case 2:
    return new PMatrix3D(
      cos(HALF_PI*direction), -sin(HALF_PI*direction), 0, 0, 
      sin(HALF_PI*direction), cos(HALF_PI*direction), 0, 0, 
      0, 0, 1, 0, 
      0, 0, 0, 1
      );
  default:
    return null;
  }
}

PeasyCam cam;
Cube cube;
int dimension = 3;
String sequence;
int index = 0;
boolean randomMoves = false;

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 400);
  cube = new Cube(dimension);
  sequence = randomString(20);
}

void draw() {
  background(200);
  cube.display();
  if (randomMoves && index < sequence.split("").length && frameCount%20 == 0) {
    cube.move(sequence.charAt(index)+"");
    index++;
  }
}

void keyPressed() {
  if (key == '+') {
    dimension++;
    cube = new Cube(dimension);
  } else if (key == '-') {
    dimension--;
    cube = new Cube(dimension);
  }
  cube.move(key+"");
}

String randomString(int n) {
  String s = "";
  for (int i = 0; i < n; i++) {
    float rand = random(6);
    String newChar;
    if (rand<1) newChar = "u";
    else if (rand<2) newChar = "d";
    else if (rand<3) newChar = "f";
    else if (rand<4) newChar = "b";
    else if (rand<5) newChar = "l";
    else newChar = "r";
    if (random(1) < 0.5) newChar = newChar.toUpperCase();
    s += newChar;
  }
  return s;
}
