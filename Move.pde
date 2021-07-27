class Move {

  final PVector[] axises = {
    new PVector(1, 0, 0), 
    new PVector(0, 1, 0), 
    new PVector(0, 0, 1)
  };


  PVector axis;
  PVector translationFactor;
  int formattedCode;
  boolean rotating = false;
  float angle = 0;
  float speed = 0.002;
  int direction;
  String code = "";
  Cube cube;

  Move() {
  }

  Move(char code) {
    this.code = code+"";
    calcParameters();
  }

  //Calculate the axis of rotation, the direction and the layer (translationFactor) 
  private void calcParameters() {
    //Get the axis of rotation given the code
    if ("LlRr".contains(code)) {
      formattedCode = 0;
    } else if ("UuDd".contains(code)) {
      formattedCode = 1;
    } else if ("FfBb".contains(code)) {
      formattedCode = 2;
    } else return;
    axis = axises[formattedCode];

    //Get the direction of rotation given the case
    direction = code.toLowerCase().equals(code) ? -1 : 1;

    if ("DdFfRr".contains(code)) {  
      translationFactor = axis;
      //switch direction if needed
      direction *= -1;
    } else {
      translationFactor = PVector.mult(axis, -1);
    }
  }

  void start() {
    if (axis != null) rotating = true;
  }

  //Update the rotation and check if it's finished
  void update() {
    angle += speed*direction;
    if (direction * angle > HALF_PI) {
      rotating = false;
      perform();
    }
  }

  //Bind the cube to move 
  void setCube(Cube cube) {
    this.cube = cube;
  }

  //Save the rotation to the cube instantaneously
  void perform() {
    if (axis == null) return;
    //Iterate through the cubies to be rotated (always nine)
    for (float i = -cube.translation; i <= cube.translation; i++) {
      for (float j = -cube.translation; j <= cube.translation; j++) {
        //get the coor of the cubie basing on the axis of rotation
        PVector coor = new PVector();
        if (formattedCode == 0) coor = new PVector(0, i, j).add(translationFactor);
        else if (formattedCode == 1) coor = new PVector(i, 0, j).add(translationFactor);
        else if (formattedCode == 2) coor = new PVector(i, j, 0).add(translationFactor);
        Cubie cubie = cube.get(coor.x, coor.y, coor.z);
        
        PMatrix3D rotation = getRotation(formattedCode, direction*HALF_PI);
        
        //Apply the rotation matrix to the coor of the cubie
        rotation.mult(cubie.coor, cubie.coor);
        //Apply the rotation matrix to the axises of the cubie to change it's orientation
        rotation.mult(cubie.xDirection, cubie.xDirection);
        rotation.mult(cubie.yDirection, cubie.yDirection);
        
        cubie.roundVectors();
      }
    }
    cube.updateCubies();
    angle = 0;
  }

  //Get the matrix that describes the rotation around one axis (indexed as 0 == x, 1 == y, 2 == z) of a given angle
  private PMatrix3D getRotation(int axis, float angle) {
    switch(axis) {
    case 0:
      return new PMatrix3D(
        1, 0, 0, 0, 
        0, cos(angle), -sin(angle), 0, 
        0, sin(angle), cos(angle), 0, 
        0, 0, 0, 1
        );
    case 1:
      return new PMatrix3D(
        cos(angle), 0, sin(angle), 0, 
        0, 1, 0, 0, 
        -sin(angle), 0, cos(angle), 0, 
        0, 0, 0, 1
        );
    case 2:
      return new PMatrix3D(
        cos(angle), -sin(angle), 0, 0, 
        sin(angle), cos(angle), 0, 0, 
        0, 0, 1, 0, 
        0, 0, 0, 1
        );
    default:
      return null;
    }
  }
}
