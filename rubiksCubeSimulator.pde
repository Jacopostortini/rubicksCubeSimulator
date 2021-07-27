import peasy.*;

final int scale = 60;

PeasyCam cam;
Cube cube;
int dimension = 3;

int currentIndex = 0;
boolean moving = false;

int shuffleLength = 20;
String sequence = "";


void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 400);
  cam.rotateY(-PI/4);
  cam.rotateX(PI/6);
  cube = new Cube(dimension);
}

void draw() {
  background(200);
  if (moving) drawSequence(sequence, currentIndex);

  cube.display();
  if (moving && currentIndex < sequence.length() && !cube.move.rotating) {
    cube.animate(sequence.charAt(currentIndex));
    currentIndex++;
  } else if (currentIndex >= sequence.length()) {
    moving = false;
  }
}

void drawSequence(String sequence, int current) {
  pushMatrix();
  rotateY(-PI/4);
  rotateX(PI/6);
  textSize(20);
  for (int i = 0; i < sequence.length(); i++) {
    fill(0, 0, 255);
    if (i+1 == current) fill(255, 0, 0);
    text(sequence.charAt(i), -width/3+(i-i/17*17)*25, -height/3+i/17*25, 0);
  }
  popMatrix();
}
