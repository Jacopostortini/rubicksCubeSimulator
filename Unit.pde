class Unit {

  final int moves = 20;
  char[] genes;
  Cube origin;
  Cube cube;

  Unit(Cube cube) {
    this.cube = cube.clone();
    this.origin = cube.clone();
    genes = new char[moves];
    String sequence = randomString(moves);
    for (int i = 0; i < moves; i++) {
      genes[i] = sequence.charAt(i);
    }
  }

  void mutate(float rate) {
    for (int i = 0; i < moves; i++) {
      float r = random(1);
      if (r < rate) {
        genes[i] = randomChar();
      }
    }
  }

  Unit cross(Unit parent) {
    Unit child = new Unit(origin.clone());
    for (int i = 0; i < moves; i++) {
      if (i < moves/2) {
        child.genes[i] = genes[i];
      } else {
        child.genes[i] = parent.genes[i];
      }
    }
    child.mutate(0.5);
    return child;
  }

  Unit cross(Unit parent, float mutation) {
    Unit child = new Unit(origin.clone());
    for (int i = 0; i < moves; i++) {
      if (i < moves/2) {
        child.genes[i] = genes[i];
      } else {
        child.genes[i] = parent.genes[i];
      }
    }
    child.mutate(mutation);
    return child;
  }

  float fitness() {
    float fitness = 0;
    for (int i = 0; i < cube.dimension; i++) {
      for (int j = 0; j < cube.dimension; j++) {
        for (int k = 0; k < cube.dimension; k++) {
          Cubie cubie = cube.cubies[i][j][k];
          if(cubie.isCorrect() && !cubie.isCenter()){
            if(cubie.coor.y == 1) fitness += 1;
          }
        }
      }
    }
    return fitness;
  }

  void apply() {
    cube.shuffle(getSequence());
  }

  String getSequence() {
    String s = "";
    for (char c : genes) s += c;
    return s;
  }

  boolean equals(Unit other) {
    for (int i = 0; i < moves; i++) {
      if (genes[i] != other.genes[i]) return false;
    }
    return true;
  }
}
