import peasy.*;

final int scale = 60;
float fontSize = scale * 3 / 5;

PeasyCam cam;
Cube cube;
Population population;
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
  
  textSize(fontSize);
  textAlign(CENTER);
}
Unit best;

void draw() {
  background(200);
  best.cube.display();
  //cube.display();
  population = population.reproduce();
  calcGeneration();
  best = population.getBestFit();

  pushMatrix();
  rotateY(-PI/4);
  rotateX(PI/6);
  text("Generation:"+population.generation, 0, -height/5, 0);
  textSize(10);
  text("Max fit:"+population.getMaxFit()/*+"; Average:"+round(population.getAverageFitness()*100)/100.+"; Variance:"+round(population.getVariance()*100)/100.*/, 0, -height/5+20, 0);
  text("Correct sequence:"+invertString(firstSequence)+";  Best sequence:"+best.getSequence(), 0, -height/5+30, 0);  
  popMatrix();
}

void calcGeneration() {
  for (Unit unit : population.units) unit.apply();
  population.calcFitnesses();
  population.calcProbabilities();
}
