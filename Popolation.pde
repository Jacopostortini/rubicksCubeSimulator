class Population {
  Unit[] units;
  float[] fitnesses;
  float[] probabilities;
  int generation = 1;
  int size = 100;
  Cube cube;

  Population(Cube cube) {
    this.cube = cube;
    units = new Unit[size];
    fitnesses = new float[size];
    probabilities = new float[size];
    for (int i = 0; i < size; i++) {
      units[i] = new Unit(cube);
    }
  }


  Population reproduce() {
    Population pop = new Population(cube);
    Unit bestFit = getBestFit();
    pop.units[0] = bestFit.cross(bestFit, 0);
    for (int i = 1; i < size; i++) {
      Unit mother = pickParent();
      Unit father = pickParent();
      pop.units[i] = mother.cross(father);
    }
    pop.generation = generation+1;
    return pop;
  }

  void calcFitnesses() {
    for (int i = 0; i < size; i++) {
      Unit unit = units[i];
      unit.apply();
      fitnesses[i] = unit.fitness();
    }
  }

  void calcProbabilities() {
    float sum = 0;
    for (float fitness : fitnesses) sum += fitness;

    for (int i = 0; i < size; i++) {
      probabilities[i] = fitnesses[i]/sum;
    }
  }

  Unit getBestFit() {
    float max = -1;
    int index = 0;
    for (int i = 0; i < size; i++) {
      if (fitnesses[i] > max) {
        max = fitnesses[i];
        index = i;
      }
    }
    return units[index];
  }

  float getMaxFit() {
    float max = -1;
    for (int i = 0; i < size; i++) {
      if (fitnesses[i] > max) {
        max = fitnesses[i];
      }
    }
    return max;
  }

  Unit pickParent() {
    float r = random(1);
    int currentIndex = -1;
    while (r > 0) {
      currentIndex++;
      r -= probabilities[currentIndex];
    }
    return units[currentIndex];
  }
}
