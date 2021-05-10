import java.util.*;

class Wire {

  float xOne, yOne, xTwo, yTwo, yOffset;
  boolean drawing = true;

  Wire(float xOne, float yOne, float xTwo, float yTwo, float offset) {
    this.xOne = xOne;
    this.yOne = yOne;
    this.xTwo = xTwo;
    this.yTwo = yTwo;
    yOffset = offset;
    println(yOffset);
  }

  void update(float xOne, float yOne, float xTwo, float yTwo) {
    this.xOne = xOne;
    this.yOne = yOne;
    this.xTwo = xTwo;
    this.yTwo = yTwo;
  }

  void display() {
    if (drawing) {
      noFill();
      beginShape();
      vertex(xOne, yOne);
      if (xTwo <= xOne) {
        if (yTwo <= yOne) {
          vertex(xOne+10, yOne);
          vertex(xOne+10, yOne-60);
          if (abs(yOne-yTwo) > 105-yOffset) {
            vertex(xOne-abs((xOne-xTwo+10)), yOne-abs(yTwo-yOne+(60-yOffset)));
          } else {
            vertex(xTwo+110, yTwo-(60+yOffset));
            vertex(xOne-abs((xOne-xTwo+10)), yTwo-(60+yOffset));
          }
          vertex(xOne-abs((xOne-xTwo+10)), yTwo);
        }
        if (yTwo > yOne) {
          if (abs(xOne-xTwo) > 105) {
            vertex(xOne+10, yOne);
            vertex(xOne+10, yTwo+60-yOffset);
          } else {
            vertex(xTwo+110, yOne);
          }
          vertex(xTwo+110, yTwo+60-yOffset);
          vertex(xOne-abs((xOne-xTwo+10)), yTwo+60-yOffset);
          vertex(xOne-abs((xOne-xTwo+10)), yTwo);
        }
      }
      vertex(xTwo, yTwo);
      endShape();
    }
  }

  void undraw() {
    drawing = false;
  }
}
