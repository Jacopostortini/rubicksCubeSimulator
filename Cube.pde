class Cube {

  float translation;
  int dimension;
  Cubie[][][] cubies;
  boolean rotating = false;
  Move move = null;


  Cube(int dimension) {
    this.dimension = dimension;
    move = new Move();
    cubies = new Cubie[dimension][dimension][dimension];
    translation = (dimension-1)/2.;
    for (float i = -translation; i <= translation; i++) {
      for (float j = -translation; j <= translation; j++) {
        for (float k = -translation; k <= translation; k++) {
          cubies[fromCenterToCorner(i)][fromCenterToCorner(j)][fromCenterToCorner(k)] = new Cubie(i, j, k);
        }
      }
    }
  }

//Display the cube and take care of the state of animation
  void display() {
    for (float i = -translation; i <= translation; i++) {
      for (float j = -translation; j <= translation; j++) {
        for (float k = -translation; k <= translation; k++) {
          pushMatrix();
          if (move.rotating) {
            move.update();
            //If this is one of the cubies to be rotated (make zero the coor not relative to the axis of rotation and check the layer
            PVector v = new PVector(i*move.axis.x, j*move.axis.y, k*move.axis.z);
            if (v.x == move.translationFactor.x && v.y == move.translationFactor.y && v.z == move.translationFactor.z) {
              rotate(move.angle, move.axis.x, move.axis.y, move.axis.z);
            }
          }
          get(i, j, k).display();
          popMatrix();
        }
      }
    }
  }
  
//Start a single move animation
  void animate(char code) {    
    if (move.rotating) return;
    move = new Move(code);
    move.setCube(this);
    move.start();
  }
  
//Perform a single move instantaneously
  void move(char code){
    if(move.rotating) return;
    move = new Move(code);
    move.setCube(this);
    move.perform();
  }

//Get the cubie at a certain position using the centered system
  Cubie get(float i, float j, float k) {
    return cubies[fromCenterToCorner(i)][fromCenterToCorner(j)][fromCenterToCorner(k)];
  }
  
//Switch from centered system to corner (used to index 3d array)
  int fromCenterToCorner(float i) {
    return round(i+(dimension-1)/2.);
  }

//Update the position of the cubies in the 3d array according to their position on the screen 
  void updateCubies() {
    Cubie[][][] newCubies = new Cubie[dimension][dimension][dimension];
    for (int i = 0; i < dimension; i++) {
      for (int j = 0; j < dimension; j++) {
        for (int k = 0; k < dimension; k++) {
          Cubie cubie = cubies[i][j][k];
          newCubies[fromCenterToCorner(cubie.coor.x)][fromCenterToCorner(cubie.coor.y)][fromCenterToCorner(cubie.coor.z)] = cubie;
        }
      }
    }
    cubies = newCubies;
  }
    
//Shuffle the cube by a given sequence instantaneously
  void shuffle(String sequence) {
    for(int i = 0; i < sequence.length(); i++){
      move(sequence.charAt(i));
    }
  }
}
