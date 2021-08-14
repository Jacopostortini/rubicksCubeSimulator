import peasy.*;

final int scale = 60;
float fontSize = scale * 3 / 5;

PeasyCam cam;
Cube cube;
int shuffleLength = 20;
//Population population;
String sequence;
boolean moving = false;
int currentIndex = -1;

void setup() {
  size(1000, 600, P3D);
  //fullScreen(P3D);
  cam = new PeasyCam(this, 400);
  cam.rotateY(-PI/4);
  cam.rotateX(PI/6);
  cube = new Cube(3);
  //cube.shuffle(firstSequence);
  //population = new Population(cube);
  //calcGeneration();
  //best = population.getBestFit();

  textSize(fontSize);
  textAlign(CENTER);
}
//Unit best;

void draw() {
  background(200);
  //best.cube.display();
  cube.display();
  if (moving) {
    if (!cube.move.rotating) {
      currentIndex++;
      if (currentIndex == sequence.length()) {
        moving = false;
        sequence = null;
      } else cube.animate(sequence.charAt(currentIndex));
    }
  }
  //population = population.reproduce();
  //calcGeneration();
  //best = population.getBestFit();

  if (sequence != null) {
    pushMatrix();
    rotateY(-PI/4);
    rotateX(PI/6);
    //text("Generation:"+population.generation, 0, -height/5, 0);
    //textSize(10);
    //text("Max fit:"+population.getMaxFit()/*+"; Average:"+round(population.getAverageFitness()*100)/100.+"; Variance:"+round(population.getVariance()*100)/100.*/, 0, -height/5+20, 0);
    //text("Correct sequence:"+invertString(firstSequence)+";  Best sequence:"+best.getSequence(), 0, -height/5+30, 0);
    for (int i = 0; i < sequence.length(); i++) {
      fill( i == currentIndex ? #ff0000 : #00ff00);
      text(sequence.charAt(i), (i-sequence.length()/2)*20, -height/3, 0);
    }
    popMatrix();
  }
}

//void calcGeneration() {
//  for (Unit unit : population.units) unit.apply();
//  population.calcFitnesses();
//  population.calcProbabilities();
//}
