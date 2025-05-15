// Arrow Class
class Arrow {
  float x, y;
  float speed;

  Arrow(float x, float y) { // passing x and y positions for the archer as initial values
    this.x = x;
    this.y = y;
    speed = 5.5; // default speed
  }

  void display() {
    stroke(0);
    fill(20, 10, 0);
    rect(x, y, 25, 1.5); // y = mouseY follows archer
  }

  //update posision
  void move() {
    x += speed; // target direction
  }

  boolean offScreen() {
    return x > width;
  }
}
