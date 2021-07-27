import peasy.*;

final int scale = 60;

PeasyCam cam;
Cube cube;
Population population;
/*
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
 */

int gene = -1;
String firstSequence = pseudoRandomString(20);

void setup() {
  //size(600, 600, P3D);
  fullScreen(P3D);
  cam = new PeasyCam(this, 400);
  cam.rotateY(-PI/4);
  cam.rotateX(PI/6);
  cube = new Cube(3);
  cube.shuffle(firstSequence);
  population = new Population(cube);
  calcGeneration();
  best = population.getBestFit();
  firstClone = cube.clone();
  firstClone.shuffle(best.getSequence());
}
Unit best;
Cube firstClone;

void draw() {
  background(200);
  //best.cube.display();
  //pushMatrix();
  //translate(1500, 800, 0);
  firstClone.display();
  //popMatrix();
  //if (!best.cube.move.rotating) {
  //  gene++;
  //  if (gene < best.genes.length) {
  //    best.cube.animate(best.genes[gene]);
  //  } else {
      gene = -1;
      population = population.reproduce();
      calcGeneration();
      best = population.getBestFit();
      firstClone = cube.clone();
      firstClone.shuffle(best.getSequence());
    //}
  //}

  pushMatrix();
  rotateY(-PI/4);
  rotateX(PI/6);
  text("Max fit:"+population.getMaxFit()+";  Generation:"+population.generation, 0, -height/5, 0);
  textSize(10);
  text("Correct sequence:"+invertString(firstSequence)+";  Best sequence:"+best.getSequence(), 0, -height/5+20, 0);
  popMatrix();
}

void calcGeneration() {
  for (Unit unit : population.units) unit.apply();
  population.calcFitnesses();
  population.calcProbabilities();
}
