class Cubie {

  PVector coor;
  PVector yDirection;
  PVector xDirection;
  boolean highlight;

  Cubie(float i, float j, float k, boolean highlight) {
    coor = new PVector(i, j, k);
    yDirection = new PVector(0, -1, 0);
    xDirection = new PVector(-1, 0, 0);
    this.highlight = highlight;
  }

  void display() {
    pushMatrix();
    translate(coor.x*scale, coor.y*scale, coor.z*scale);
    strokeWeight(5);
    stroke(0);
    if (highlight) strokeWeight(15);
    noFill();
    box(scale);
    if (highlight) {
      stroke(100, 0, 0);
      line(0, 0, 0, yDirection.x*scale, yDirection.y*scale, yDirection.z*scale);
      stroke(0, 100, 0);
      line(0, 0, 0, xDirection.x*scale, xDirection.y*scale, xDirection.z*scale);
      stroke(0);
    }

    PVector zDirection = yDirection.cross(xDirection);
    PMatrix3D matrix = new PMatrix3D(
      xDirection.x, yDirection.x, zDirection.x, 0, 
      xDirection.y, yDirection.y, zDirection.y, 0, 
      xDirection.z, yDirection.z, zDirection.z, 0, 
      0, 0, 0, 1
      );
    applyMatrix(matrix);

    if (highlight) {
      stroke(255, 0, 0);
      line(10, 0, 10, 10, scale, 10);
      stroke(0, 255, 0);
      line(0, 10, 10, scale, 10, 10);
      stroke(0);
    }
    displayFaces();
    popMatrix();
  }

  void displayFaces() {
    float radius = 0.5 * scale;
    float fontSize = scale * 3 / 5;

    textSize(fontSize);
    textAlign(CENTER);
    noStroke();
    beginShape(QUAD);

    //Up
    fill(colors[0]);
    //noFill();
    vertex(-radius, radius, -radius);
    vertex(radius, radius, -radius);
    vertex(radius, radius, radius);
    vertex(-radius, radius, radius);
    //if (coor.x == 1 && coor.y == 0 && coor.z == 1) {
    //  endShape();
    //  pushMatrix();
    //  rotateX(HALF_PI);
    //  fill(0);
    //  text("U", 0, radius/2, radius*1.1);
    //  popMatrix();
    //  beginShape();
    //}

    //Down
    fill(colors[3]);
    //noFill();
    vertex(-radius, -radius, -radius);
    vertex(radius, -radius, -radius);
    vertex(radius, -radius, radius);
    vertex(-radius, -radius, radius);
    //if (coor.x == 1 && coor.y == 2 && coor.z == 1) {
    //  endShape();
    //  pushMatrix();
    //  rotateX(-HALF_PI);
    //  fill(0);
    //  text("D", 0, radius/2, radius*1.1);
    //  popMatrix();
    //  beginShape();
    //}

    //Left
    fill(colors[1]);
    //noFill();
    vertex(radius, -radius, -radius);
    vertex(radius, radius, -radius);
    vertex(radius, radius, radius);
    vertex(radius, -radius, radius);
    //if (coor.x == 0 && coor.y == 1 && coor.z == 1) {
    //  endShape();
    //  pushMatrix();
    //  rotateY(-HALF_PI);
    //  fill(0);
    //  text("L", 0, radius/2, radius*1.1);
    //  popMatrix();
    //  beginShape();
    //}

    //Right
    fill(colors[4]);
    //noFill();
    vertex(-radius, -radius, -radius);
    vertex(-radius, radius, -radius);
    vertex(-radius, radius, radius);
    vertex(-radius, -radius, radius);
    //if (coor.x == 2 && coor.y == 1 && coor.z == 1) {
    //  endShape();
    //  pushMatrix();
    //  rotateY(HALF_PI);
    //  fill(0);
    //  text("R", 0, radius/2, radius*1.1);
    //  popMatrix();
    //  beginShape();
    //}

    //Front
    fill(colors[2]);
    //noFill();
    vertex(-radius, -radius, -radius);
    vertex(-radius, radius, -radius);
    vertex(radius, radius, -radius);
    vertex(radius, -radius, -radius);
    //if (coor.x == 1 && coor.y == 1 && coor.z == 2) {
    //  endShape();
    //  fill(0);
    //  text("F", 0, radius/2, radius*1.1);
    //  beginShape();
    //}

    //Back
    fill(colors[5]);
    //noFill();
    vertex(-radius, -radius, radius);
    vertex(-radius, radius, radius);
    vertex(radius, radius, radius);
    vertex(radius, -radius, radius);
    //if (coor.x == 1 && coor.y == 1 && coor.z == 0) {
    //  endShape();
    //  pushMatrix();
    //  fill(0);
    //  rotateY(PI);
    //  text("B", 0, radius/2, radius*1.1);
    //  popMatrix();
    //  beginShape();
    //}

    endShape();
  }

  void roundVectors() {
    coor.x = round(coor.x);
    coor.y = round(coor.y);
    coor.z = round(coor.z);
    yDirection.x = round(yDirection.x);
    yDirection.y = round(yDirection.y);
    yDirection.z = round(yDirection.z);
    xDirection.x = round(xDirection.x);
    xDirection.y = round(xDirection.y);
    xDirection.z = round(xDirection.z);
  }
}
