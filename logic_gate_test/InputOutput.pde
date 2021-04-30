class Node {

  float positionX, positionY;
  float nodeRadius = 5;
  boolean state = false;
  boolean isSelected = false;

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
  
  void unselect(){
    isSelected = false;
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
      isSelected = !isSelected;
      return true;
    } else {
      isSelected = false;
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
    if (isSelected) {
      fill(255, 0, 0);
    } else {
      fill(0);
    }
    ellipse(positionX, positionY, 2*nodeRadius, 2*nodeRadius);
  }

  float getOffsetY() {
    return 50-offsetY;
  }

  String getInfo() {
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
    line(positionX, positionY, connectedInput.getPositionX(), connectedInput.getPositionY());
    connectedInput.setState(getState());
    connectedInput.unselect();
    unselect();
  }

  void disconnect() {
    connectedInput.setState(false);
    connectedInput = null;
  }

  void display() {
    if (isSelected) {
      fill(255, 0, 0);
    } else {
      fill(0);
    }
    ellipse(positionX, positionY, 2*nodeRadius, 2*nodeRadius);
    if (connectedInput != null) {
      connectedInput.setState(getState());
      line(positionX, positionY, connectedInput.getPositionX(), connectedInput.getPositionY());
    }
  }
}
