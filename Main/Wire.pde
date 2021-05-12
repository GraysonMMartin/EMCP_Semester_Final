import java.util.*;

class Wire {
  //class representing a wire connection between an output node and input node

  float xOne, yOne, xTwo, yTwo, yOffset;
  boolean drawing = true;

  Wire(float xOne, float yOne, float xTwo, float yTwo, float offset) {
    this.xOne = xOne;
    this.yOne = yOne;
    this.xTwo = xTwo;
    this.yTwo = yTwo;
    yOffset = offset;
  }

  void update(float xOne, float yOne, float xTwo, float yTwo) {
    //updates the node positions
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
        //if the connected input is behind the output
        if (yTwo <= yOne) {
          //if the input is above or level with the output
          vertex(xOne+10, yOne);
          vertex(xOne+10, yOne-60);
          if (abs(yOne-yTwo) > 105-yOffset) {
            //if the wire can go underneath the connected input's gate
            vertex(xOne-abs((xOne-xTwo+10)), yOne-abs(yTwo-yOne+(60-yOffset)));
          } else {
            //if the wire must go around the top of the connected input's gate
            vertex(xTwo+110, yTwo-(60+yOffset));
            vertex(xOne-abs((xOne-xTwo+10)), yTwo-(60+yOffset));
          }
          vertex(xOne-abs((xOne-xTwo+10)), yTwo);
        }
        if (yTwo > yOne) {
          //if the connected input is below the output
          if (abs(yTwo-yOne) > 110) {
            //if the wire can be drawn above the connected input's logic gate
            vertex(xOne+10, yOne);
            vertex(xOne+10, yOne+60);
            vertex(xTwo-10, yOne+60);
            vertex(xTwo-10, yTwo);
          } else {
            //if the wire must go around the bottom of the connected input's logic gate
            vertex(xOne+10, yOne);
            vertex(xOne+10, yTwo+60-yOffset);
            vertex(xTwo+110, yTwo+60-yOffset);
            vertex(xOne-abs((xOne-xTwo+10)), yTwo+60-yOffset);
            vertex(xOne-abs((xOne-xTwo+10)), yTwo);
          }
        }
      } else {
        //connect the gates with a vertex just beyond the output and a vertex directly left of the connected input
        vertex(xOne+10, yOne);
        vertex(xOne+10, yTwo);
      }

      vertex(xTwo, yTwo);
      endShape();
    }
  }
  void undraw() {
    //stop drawing the wire
    drawing = false;
  }
}
