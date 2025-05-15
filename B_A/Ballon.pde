// Balloon Class
class Balloon {
  float x, y;
  float speed;
  float acceleration;
  boolean isYellow;

  Balloon(float x, float y, boolean isYellow, float acceleration) {
    this.x = x;
    this.y = y;
    this.isYellow = isYellow;
    this.acceleration = acceleration;
    speed = 1.6; // default speed
  }

  void display() {
    if (isYellow) {
      stroke(0);
      fill(220, 220, 0);
    } else {
      stroke(0);
      fill(170, 0, 0);
    }
    ellipse(x, y, 30, 40); // radius = 15 from x and 20 from y
    line(x, y+13, x, y+16);
    line(x+1, y+16, x+1, y+26);
  }

  // update positions
  void move() {
    y -= speed; // Moving upwards
    speed += acceleration;
    if (y < -20) { // the ballon is totally out of screen
      y = height; // start from the bottom again
    }
  }

  boolean hit(Arrow arrow) {
    // check crashing
    float d = dist(x, y, arrow.x, arrow.y);
    // x is the center of every ballon from width = 0 , "window start" >> increases >>
    // y is the distance from the top of the window , and in case of moving up , y decreases
    // arrow.x is the recent x posittion of the arrow
    // arrow.y is the recent y position of arrow, which is always = mouseY
    if (d < 20) {
      return true;
    } // if true then remove the balloon and increase the num of shooted balloons
    else {
      return false;
    }
  }
}
