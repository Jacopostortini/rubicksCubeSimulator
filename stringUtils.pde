String randomString(int n) {
  String s = "";
  for (int i = 0; i < n; i++) {
    s += randomChar();
  }
  return s;
}

String pseudoRandomString(int n) {
  String s = "";
  for (int i = 0; i < n; i++) {
    
    String lastChar = s.length() == 0 ? "" : s.charAt(s.length()-1)+"";
    String forbiddenChar = lastChar.toUpperCase().equals(lastChar) ? lastChar.toLowerCase() : lastChar.toUpperCase();
    String newChar = forbiddenChar;
    int counter = 0;

    while (forbiddenChar.equals(newChar) && counter < 1000) {
      newChar = randomChar()+"";
      counter++;
    }
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

char randomChar() {
  String newChar = "";
  float rand = random(6);

  if (rand<1) newChar = "u";
  else if (rand<2) newChar = "d";
  else if (rand<3) newChar = "f";
  else if (rand<4) newChar = "b";
  else if (rand<5) newChar = "l";
  else newChar = "r";
  if (random(1) < 0.5) newChar = newChar.toUpperCase();
  
  return newChar.charAt(0);
}
