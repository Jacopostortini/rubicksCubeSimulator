class Cube {

  float translation;
  int dimension;
  Cubie[][][] cubies;


  Cube(int dimension) {
    this.dimension = dimension;
    cubies = new Cubie[dimension][dimension][dimension];
    translation = (dimension-1)/2.;
    for (float i = -translation; i <= translation; i++) {
      for (float j = -translation; j <= translation; j++) {
        for (float k = -translation; k <= translation; k++) {
          cubies[fromCenterToCorner(i)][fromCenterToCorner(j)][fromCenterToCorner(k)] = new Cubie(i, j, k, /*(i==1 && j==-1 && k==1)*/false);
        }
      }
    }
  }

  void display() {
    for (float i = -translation; i <= translation; i++) {
      for (float j = -translation; j <= translation; j++) {
        for (float k = -translation; k <= translation; k++) {
          get(i, j, k).display();
        }
      }
    }
  }

  void move(String code) {

    //Get the axis of rotation given the code
    int formattedCode;
    if ("LlRr".contains(code)) {
      formattedCode = 0;
    } else if ("UuDd".contains(code)) {
      formattedCode = 1;
    } else if ("FfBb".contains(code)) {
      formattedCode = 2;
    } else return;
    PVector axis = axises[formattedCode];

    //Get the direction of rotation given the case
    int direction = code.toLowerCase().equals(code) ? -1 : 1;

    //get the translation to apply to the 0 element of the index (e.g. to cover the cases (i, j, 2)) 
    PVector translationFactor;
    if ("DdFfRr".contains(code)) {
      translationFactor = axis;
      //switch direction if needed
      direction *= -1;
    } else {
      translationFactor = PVector.mult(axis, -1);
    }

    for (float i = -translation; i <= translation; i++) {
      for (float j = -translation; j <= translation; j++) {
        PVector coor = new PVector();
        if (formattedCode == 0) coor = new PVector(0, i, j).add(translationFactor);
        else if (formattedCode == 1) coor = new PVector(i, 0, j).add(translationFactor);
        else if (formattedCode == 2) coor = new PVector(i, j, 0).add(translationFactor);
        
        Cubie cubie = get(coor.x, coor.y, coor.z);
        PMatrix3D rotation = getRotation(formattedCode, direction);
        rotation.mult(cubie.coor, cubie.coor);
        rotation.mult(cubie.xDirection, cubie.xDirection);
        rotation.mult(cubie.yDirection, cubie.yDirection);
        cubie.roundVectors();
      }
    }
  }

  Cubie get(float i, float j, float k) {
    return cubies[round(i+(dimension-1)/2.)][round(j+(dimension-1)/2.)][round(k+(dimension-1)/2.)];
  }

  int fromCenterToCorner(float i) {
    return round(i+(dimension-1)/2.);
  }
}
