void keyPressed() {
  if (key == ' ') {
    sequence = randomString(shuffleLength);
    sequence += invertString(sequence);
    moving = true;
    currentIndex = 0;
  } else if (key == 's') {
    sequence = randomString(shuffleLength);
    moving = true;
    currentIndex = 0;
  } else if (key == 'S') {
    sequence = randomString(shuffleLength);
    cube.shuffle(sequence);
  } else if (key == 'r') {
    cube = new Cube(dimension);
  } else {
    cube.animate(key);
  }
}
