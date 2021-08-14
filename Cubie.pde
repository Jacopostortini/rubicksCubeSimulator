class Cubie {
  final color[] colors = {
    //Yellow Red Green
    #FFFF00, #FF0000, #00FF00, 
    //White Orange Blue
    #FFFFFF, #FFA500, #0000FF 
  };

  PVector coor;
  PVector yDirection;
  PVector xDirection;

  Cubie(float i, float j, float k) {
    coor = new PVector(i, j, k);
    yDirection = new PVector(0, -1, 0);
    xDirection = new PVector(1, 0, 0);
  }

  void display() {
    pushMatrix();
    translate(coor.x*scale, coor.y*scale, coor.z*scale);
    //Draw the edges of each cubie
    strokeWeight(scale/10);
    //if (isCorrect() && !isCenter()) strokeWeight(scale/3);

    stroke(0);
    noFill();
    box(scale);
    //Each cubie as it's own XYZ system, X points right (red face), Y points up (yellow face)
    //Calculate the Z axis using vector product and then rotate the space making shure that the axises match the one of the cubie
    PVector zDirection = yDirection.cross(xDirection);
    PMatrix3D matrix = new PMatrix3D(
      xDirection.x, yDirection.x, zDirection.x, 0, 
      xDirection.y, yDirection.y, zDirection.y, 0, 
      xDirection.z, yDirection.z, zDirection.z, 0, 
      0, 0, 0, 1
      );
    applyMatrix(matrix);

    displayFaces();
    popMatrix();
  }

  void displayFaces() {
    float radius = 0.5 * scale;
    textSize(fontSize);
    noStroke();
    beginShape(QUAD);

    //Up (yellow)
    fill(colors[0]);
    vertex(-radius, radius, -radius);
    vertex(radius, radius, -radius);
    vertex(radius, radius, radius);
    vertex(-radius, radius, radius);
    if (coor.x == 0 && coor.y == -1 && coor.z == 0) {
      endShape();
      pushMatrix();
      rotateX(HALF_PI);
      fill(0);
      text("U", 0, radius/2, -radius*1.1);
      popMatrix();
      beginShape(QUAD);
    }

    //Down (white)
    fill(colors[3]);
    vertex(-radius, -radius, -radius);
    vertex(radius, -radius, -radius);
    vertex(radius, -radius, radius);
    vertex(-radius, -radius, radius);
    if (coor.x == 0 && coor.y == 1 && coor.z == 0) {
      endShape();
      pushMatrix();
      rotateX(-HALF_PI);
      fill(0);
      text("D", 0, radius/2, -radius*1.1);
      popMatrix();
      beginShape(QUAD);
    }

    //Left (orange)
    fill(colors[1]);
    vertex(-radius, -radius, -radius);
    vertex(-radius, radius, -radius);
    vertex(-radius, radius, radius);
    vertex(-radius, -radius, radius);
    if (coor.x == -1 && coor.y == 0 && coor.z == 0) {
      endShape();
      pushMatrix();
      rotateY(-HALF_PI);
      rotateX(PI);
      fill(0);
      text("L", 0, radius/2, -radius*1.1);
      popMatrix();
      beginShape(QUAD);
    }

    //Right (red)
    fill(colors[4]);
    vertex(radius, -radius, -radius);
    vertex(radius, radius, -radius);
    vertex(radius, radius, radius);
    vertex(radius, -radius, radius);
    if (coor.x == 1 && coor.y == 0 && coor.z == 0) {
      endShape();
      pushMatrix();
      rotateY(HALF_PI);
      rotateX(PI);
      fill(0);
      text("R", 0, radius/2, -radius*1.1);
      popMatrix();
      beginShape(QUAD);
    }

    //Front (green)
    fill(colors[2]);
    vertex(-radius, -radius, radius);
    vertex(-radius, radius, radius);
    vertex(radius, radius, radius);
    vertex(radius, -radius, radius);
    if (coor.x == 0 && coor.y == 0 && coor.z == 1) {
      endShape();
      pushMatrix();
      fill(0);
      rotateZ(PI);
      rotateY(PI);
      text("F", 0, radius/2, -radius*1.1);
      popMatrix();
      beginShape(QUAD);
    }

    //Back (blue)
    fill(colors[5]);
    vertex(-radius, -radius, -radius);
    vertex(-radius, radius, -radius);
    vertex(radius, radius, -radius);
    vertex(radius, -radius, -radius);
    if (coor.x == 0 && coor.y == 0 && coor.z == -1) {
      endShape();
      pushMatrix();
      fill(0);
      rotateZ(PI);
      text("B", 0, radius/2, -radius*1.1);
      popMatrix();
      beginShape(QUAD);
    }

    endShape();
  }

  //To avoid problems from E-4 or things like that during calculations
  void roundVectors() {
    coor.x = round(coor.x);
    coor.y = round(coor.y);
    coor.z = round(coor.z);
    xDirection.x = round(xDirection.x);
    xDirection.y = round(xDirection.y);
    xDirection.z = round(xDirection.z);
    yDirection.x = round(yDirection.x);
    yDirection.y = round(yDirection.y);
    yDirection.z = round(yDirection.z);
  }

  Cubie clone() {
    Cubie clone = new Cubie(coor.x, coor.y, coor.z);
    clone.xDirection = new PVector(xDirection.x, xDirection.y, xDirection.z);
    clone.yDirection = new PVector(yDirection.x, yDirection.y, yDirection.z);

    return clone;
  }

  boolean isCenter() {
    if (equalsVector(coor, new PVector(0, 0, 0))) return true;
    PVector absCoor = new PVector(abs(coor.x), abs(coor.y), abs(coor.z));
    if (equalsVector(absCoor, new PVector(1, 0, 0))) return true;
    if (equalsVector(absCoor, new PVector(0, 1, 0))) return true;
    if (equalsVector(absCoor, new PVector(0, 0, 1))) return true;
    return false;
  }

  boolean isCorrect() {
    return equalsVector(xDirection, new PVector(1, 0, 0)) && equalsVector(yDirection, new PVector(0, -1, 0));
  }
}
