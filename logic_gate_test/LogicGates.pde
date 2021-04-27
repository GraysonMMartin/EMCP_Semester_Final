class LogicGate {
  boolean outputState = false;
  float posX, posY;
  OutputNode outputNode;
  ArrayList<InputNode> inputNodes = new ArrayList<InputNode>();
  color backgroundColor = color(255);

  LogicGate(float positionX, float positionY, int numberOfInputs) {
    posX = positionX;
    posY = positionY;
    outputNode = new OutputNode(posX+50, posY);
    if (numberOfInputs > 0) {
      float spacing = 100/(numberOfInputs+1);
      for (int input = 0; input<numberOfInputs; input+=1) {
        inputNodes.add(new InputNode(posX-50, posY-50+spacing, spacing));
        spacing += spacing;
      }
    }
  }

  void setOutputState(boolean state) {
    outputNode.setState(state);
  }

  void move(float positionX, float positionY) {
    for (InputNode inputNode : inputNodes) {
      if (!inputNode.isClicked() && !outputNode.isClicked()) {
        inputNode.move(positionX-50, positionY+inputNode.getOffsetY());
        posX = positionX;
        posY = positionY;
        outputNode.move(positionX+50, positionY);
      }
    }
  }

  void setBackground(boolean isHighlighted) {
    if (isHighlighted) {
      backgroundColor = color(#FFF943);
    } else {
      backgroundColor = color(255);
    }
  }

  boolean getOutputState() {
    return outputNode.getState();
  }

  boolean isClicked() {
    if (mouseX < posX + 50 && mouseX > posX - 50 && mouseY < posY + 50 && mouseY > posY - 50) {
      return true;
    } else {
      return false;
    }
  }
}

class InputGate extends LogicGate {
  boolean buttonPressed = false;

  InputGate(float positionX, float positionY) {
    super(positionX, positionY, 0);
    outputNode = new OutputNode(positionX + 50, positionY);
  }

  void move(float positionX, float positionY) {
    if (!outputNode.isClicked() && !buttonPressed) {
      posX = positionX;
      posY = positionY;
      outputNode.move(positionX+50, positionY);
    }
  }

  void switchState() {
    if (buttonPressed) {
      setOutputState(!getOutputState());
    }
  }

  void update() {
    setBackground(getOutputState());
    if (mouseX < posX+25 && mouseX > posX - 25 && mouseY < posY + 40 && mouseY > posY + 20) {
      buttonPressed = true;
    } else {
      buttonPressed = false;
    }
  }

  void display() {
    setBackground(getOutputState());
    fill(backgroundColor);
    strokeWeight(3);
    rect(posX-50, posY-50, 100, 100);
    if (getOutputState()) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    rect(posX-25, posY+20, 50, 20);
    fill(0);
    textAlign(CENTER);
    text("INPUT", posX, posY);
    outputNode.display();
  }
}

class OutputGate extends LogicGate {

  OutputGate(float positionX, float positionY) {
    super(positionX, positionY, 1);
  }

  void display() {
    setBackground(inputNodes.get(0).getState());
    fill(backgroundColor);
    strokeWeight(3);
    rect(posX-50, posY-50, 100, 100);
    fill(0);
    textAlign(CENTER);
    text("OUTPUT", posX, posY);
    inputNodes.get(0).display();
  }
}

class AndGate extends LogicGate {

  AndGate(float positionX, float positionY) {
    super(positionX, positionY, 2);
  }

  boolean getInputOneState() {
    return inputNodes.get(0).getState();
  }

  boolean getInputTwoState() {
    return inputNodes.get(1).getState();
  }

  void setInputOne(boolean state) {
    inputNodes.get(0).setState(state);
  }

  void setInputTwo(boolean state) {
    inputNodes.get(1).setState(state);
  }

  void updateOutputState() {
    if (inputNodes.get(0).getState() && inputNodes.get(1).getState()) {
      setOutputState(true);
    } else {
      setOutputState(false);
    }
  }

  void display() {
    fill(backgroundColor);
    strokeWeight(3);
    rect(posX-50, posY-50, 100, 100);
    fill(0);
    textAlign(CENTER);
    text("AND", posX, posY);
    inputNodes.get(0).display();
    inputNodes.get(1).display();
    outputNode.display();
  }

  String getInfo() {
    return "And gate at ("+str(posX)+","+str(posY)+") with output state "+str(outputState);
  }
}

class OrGate extends LogicGate {

  OrGate(float positionX, float positionY) {
    super(positionX, positionY, 2);
  }

  boolean getInputOneState() {
    return inputNodes.get(0).getState();
  }

  boolean getInputTwoState() {
    return inputNodes.get(1).getState();
  }

  void setInputOne(boolean state) {
    inputNodes.get(0).setState(state);
  }

  void setInputTwo(boolean state) {
    inputNodes.get(1).setState(state);
  }

  void updateOutputState() {
    if (inputNodes.get(0).getState() || inputNodes.get(1).getState()) {
      setOutputState(true);
    } else {
      setOutputState(false);
    }
  }

  void display() {
    fill(backgroundColor);
    strokeWeight(3);
    rect(posX-50, posY-50, 100, 100);
    fill(0);
    textAlign(CENTER);
    text("OR", posX, posY);
    inputNodes.get(0).display();
    inputNodes.get(1).display();
    outputNode.display();
  }

  String getInfo() {
    return "Or gate at ("+str(posX)+","+str(posY)+") with output state "+str(outputState);
  }
}
