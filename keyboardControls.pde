void keyPressed() {
  //if (key == ' ') {
  //  sequence = pseudoRandomString(shuffleLength);
  //  sequence += invertString(sequence);
  //  moving = true;
  //  currentIndex = 0;
  //} else if (key == 's') {
  //  sequence = pseudoRandomString(shuffleLength);
  //  moving = true;
  //  currentIndex = 0;
  //} else if (key == 'S') {
  //  sequence = pseudoRandomString(shuffleLength);
  //  cube.shuffle(sequence);
  //} else if (key == 'q') {
  //  cube = new Cube(dimension);
  //} else {
    cube.animate(key);
  //}
}
