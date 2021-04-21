class Node {

  float positionX, positionY;
  float nodeRadius = 5;
  boolean state = false;

  Node(float positionX, float positionY) {
    this.positionX = positionX;
    this.positionY = positionY;
  }

  void setState(boolean state) {
    this.state = state;
  }

  void move(float newX, float newY) {
    positionX = newX;
    positionY = newY;
  }

  boolean getState() {
    return state;
  }

  float getPositionX() {
    return positionX;
  }

  float getPositionY() {
    return positionY;
  }

  boolean isClicked() {
    if (dist(mouseX, mouseY, positionX, positionY) < nodeRadius) {
      return true;
    } else {
      return false;
    }
  }
}

class InputNode extends Node {

  float offsetY;
  InputNode(float positionX, float positionY, float offsetY) {
    super(positionX, positionY);
    this.offsetY = offsetY;
  }

  void display() {
    fill(0);
    ellipse(positionX, positionY, 2*nodeRadius, 2*nodeRadius);
  }

  float getOffsetY() {
    return 50-offsetY;
  }
  
  String getInfo(){
    return "Input Node at ("+positionX+", "+positionY+").";
  }
}

class OutputNode extends Node {
  InputNode connectedInput;

  OutputNode(float positionX, float positionY) {
    super(positionX, positionY);
    connectedInput = null;
  }

  void connect(InputNode inputNode) {
    connectedInput = inputNode;
    println("connecting");
    line(positionX,positionY,connectedInput.getPositionX(),connectedInput.getPositionY());
    connectedInput.setState(state);
  }
  
  void disconnect(){
    connectedInput.setState(false);
    connectedInput = null;
  }

  void display() {
    fill(0);
    ellipse(positionX, positionY, 2*nodeRadius, 2*nodeRadius);
    if (connectedInput != null) {
      println("connected to",connectedInput.getInfo());
      line(positionX, positionY, connectedInput.getPositionX(), connectedInput.getPositionY());
    }
  }
}
