// Archer Class
class Archer {
  float y;

  Archer() {
    y = height / 2;
  }
  void display() {
    image(arc, -80, y);
  }

  void update(float varY) {
    y = varY; //  y = mouseY
    y = constrain(y-150, -50, height-80); // gurantee that archer will not disappear from the screen
  }

  Arrow shoot() { // return a new Arrow object
    return new Arrow(90, y+110);
  }
}
