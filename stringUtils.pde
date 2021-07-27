String randomString(int n) {
  String s = "";
  for (int i = 0; i < n; i++) {
    float rand = random(6);
    String newChar;
    if (rand<1) newChar = "u";
    else if (rand<2) newChar = "d";
    else if (rand<3) newChar = "f";
    else if (rand<4) newChar = "b";
    else if (rand<5) newChar = "l";
    else newChar = "r";
    if (random(1) < 0.5) newChar = newChar.toUpperCase();
    s += newChar;
  }
  return s;
}

String invertString(String string) {
  String inverted = "";
  for (int i = string.length()-1; i >= 0; i--) {
    String c = string.charAt(i)+"";
    if (c.toUpperCase().equals(c)) c = c.toLowerCase();
    else c = c.toUpperCase();
    inverted += c;
  } 
  return inverted;
}
