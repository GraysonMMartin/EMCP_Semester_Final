class Wire {

  float xOne, yOne, xTwo, yTwo;
  boolean drawing = true;

  Wire(float xOne, float yOne, float xTwo, float yTwo) {
    this.xOne = xOne;
    this.yOne = yOne;
    this.xTwo = xTwo;
    this.yTwo = yTwo;
  }

  void update(float xOne, float yOne, float xTwo, float yTwo) {
    this.xOne = xOne;
    this.yOne = yOne;
    this.xTwo = xTwo;
    this.yTwo = yTwo;
  }

  void display() {
    if (drawing) {
      line(xOne, yOne, xTwo, yTwo);
    }
  }

  void undraw() {
    drawing = false;
  }
}
