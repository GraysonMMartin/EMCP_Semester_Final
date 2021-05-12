class LogicGate {
  //parent class for all logic gate classes

  boolean outputState = false;
  float posX, posY;
  OutputNode outputNode;
  ArrayList<InputNode> inputNodes = new ArrayList<InputNode>();
  color backgroundColor = color(255);

  LogicGate(float positionX, float positionY, int numberOfInputs) {
    posX = positionX;
    posY = positionY;
    //add an output node
    outputNode = new OutputNode(posX+50, posY);
    if (numberOfInputs > 0) {
      //add the specified number of inputs at an equal distance from the center of the gate to the top and bottom of the gate
      float spacing = 100/(numberOfInputs+1);
      for (int input = 0; input<numberOfInputs; input+=1) {
        inputNodes.add(new InputNode(posX-50, posY-50+spacing, spacing));
        spacing += spacing;
      }
    }
  }

  void setOutputState(boolean state) {
    //set the output node's T/F state
    outputNode.setState(state);
  }

  void move(float positionX, float positionY) {
    //moves the logic gate

    //check if any nodes are being clicked
    boolean nodesClicked = false;
    for (InputNode inputNode : inputNodes) {
      if (inputNode.isClicked()||outputNode.isClicked()) {
        nodesClicked = true;
        break;
      }
    }
    //only move if nodes are not being seected
    if (!nodesClicked) {
      for (InputNode inputNode : inputNodes) {
        //make sure x position is within the bounds of the sketch
        if (positionX < 50) {
          posX = 50;
        } else if (positionX > width-50) {
          posX = width-50;
        } else {
          posX = positionX;
        }
        //make sure the y position is within the bounds of the sketch
        if (positionY < 50) {
          posY = 50;
        } else if (positionY > height-50) {
          posY = height-50;
        } else {
          posY = positionY;
        }
        //move the nodes along with the gate
        inputNode.move(posX-50, posY+inputNode.getOffsetY());
        outputNode.move(posX+50, posY);
      }
    }
  }

  void setBackground(boolean isHighlighted) {
    //set the gate background to yellow if it has a true state
    if (isHighlighted) {
      backgroundColor = color(#FFF943);
    } else {
      backgroundColor = color(255);
    }
  }

  void drawOutline() {
    //draw the basic outline shared by all logic gates

    //box with appropriate color
    fill(backgroundColor);
    strokeWeight(3);
    rect(posX-50, posY-50, 100, 100);
    //delete gate button
    fill(255, 0, 0);
    rect(posX+25, posY-50, 25, 20);
    fill(0);
    textAlign(CENTER, CENTER);
    text("X", posX+37.5, posY-40);
  }

  void disconnect() {
    //disconnect all connections to this gate's input node(s)
    for (InputNode inputNode : inputNodes) {
      if (inputNode.connectedOutput != null) {
        inputNode.disconnect(inputNode.connectedOutput.connection);
      }
    }
  }

  boolean getOutputState() {
    //returns the gate's output node's T/F state
    return outputNode.getState();
  }

  boolean isClicked() {
    //returns a boolean indicating if the gate is clicked
    if (mouseX < posX + 50 && mouseX > posX - 50 && mouseY < posY + 50 && mouseY > posY - 50) {
      return true;
    } else {
      return false;
    }
  }

  boolean delete() {
    //returns a boolean indicating if the delete gate button has been pressed
    if (mouseX <=posX+50 && mouseX >=posX+25 && mouseY <=posY-30 && mouseY >= posY-50) {
      return true;
    }
    return false;
  }
}

class InputGate extends LogicGate {
  //class representing input gates
  
  boolean buttonPressed = false;

  InputGate(float positionX, float positionY) {
    super(positionX, positionY, 0);
    outputNode = new OutputNode(positionX + 50, positionY);
  }

  void move(float positionX, float positionY) {
    //special move function for the input gate since it has no input nodes
    if (!outputNode.isClicked() && !buttonPressed) {
      if (positionX < 50) {
        posX = 50;
      } else if (positionX > width-50) {
        posX = width-50;
      } else {
        posX = positionX;
      }
      if (positionY < 50) {
        posY = 50;
      } else if (positionY > height-50) {
        posY = height-50;
      } else {
        posY = positionY;
      }
      outputNode.move(posX+50, posY);
    }
  }

  void switchState() {
    //reverse the state of the input gate every time the on/off button is clicked
    if (buttonPressed) {
      setOutputState(!getOutputState());
    }
  }

  void update() {
    //update the background
    setBackground(getOutputState());
    //check if the on/off button has been pressed
    if (mouseX < posX+25 && mouseX > posX - 25 && mouseY < posY + 40 && mouseY > posY + 20) {
      buttonPressed = true;
    } else {
      buttonPressed = false;
    }
  }

  void display() {
    //display an input gate
    
    //set background to input gate's t/f state
    setBackground(getOutputState());
    drawOutline();
    if (getOutputState()) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    rect(posX-25, posY+20, 50, 20);
    stroke(0);
    fill(0);
    textAlign(CENTER);
    text("INPUT", posX, posY);
    outputNode.display();
  }
}

class OutputGate extends LogicGate {
  //class representing output gates

  OutputGate(float positionX, float positionY) {
    super(positionX, positionY, 1);
  }

  void display() {
    //display an output gate
    
    //set the background color according to the input node's t/f state
    setBackground(inputNodes.get(0).getState());
    drawOutline();
    stroke(0);
    fill(0);
    textAlign(CENTER);
    text("OUTPUT", posX, posY);
    inputNodes.get(0).display();
  }
}

class NotGate extends LogicGate {
  //class representing not gates

  NotGate(float positionX, float positionY) {
    super(positionX, positionY, 1);
  }

  boolean getInputState() {
    //returns the input node's state
    return inputNodes.get(0).getState();
  }

  void setInput(boolean state) {
    //set the gate's input state
    inputNodes.get(0).setState(state);
  }

  void updateOutputState() {
    //make output state the opposite of the input node's state
    setOutputState(!getInputState());
  }

  void display() {
    //display a not gate
    
    //set the background to the output t/f state
    setBackground(getOutputState());
    drawOutline();
    stroke(0);
    noFill();
    line(posX-30,posY,posX+-20,posY);
    triangle(posX-20,posY-20,posX-20,posY+20,posX+10,posY);
    ellipse(posX+15,posY,10,10);
    line(posX+20,posY,posX+30,posY);
    inputNodes.get(0).display();
    outputNode.display();
  }
}

class AndGate extends LogicGate {
  //class representing and gates

  AndGate(float positionX, float positionY) {
    super(positionX, positionY, 2);
  }

  boolean getInputOneState() {
    //returns the first input node's t/f state
    return inputNodes.get(0).getState();
  }

  boolean getInputTwoState() {
    //returns the second input node's t/f state
    return inputNodes.get(1).getState();
  }

  void setInputOne(boolean state) {
    //set the first input node's t/f state
    inputNodes.get(0).setState(state);
  }

  void setInputTwo(boolean state) {
    //set the second input node's t/f state
    inputNodes.get(1).setState(state);
  }

  void updateOutputState() {
    //set the output state according to and gate logic
    if (inputNodes.get(0).getState() && inputNodes.get(1).getState()) {
      setOutputState(true);
    } else {
      setOutputState(false);
    }
  }

  void display() {
    //display an and gate
    
    //set the gate's background to its output t/f state
    setBackground(getOutputState());
    drawOutline();
    stroke(0);
    noFill();
    line(posX-30,posY-5,posX-15,posY-5);
    line(posX-30,posY+5,posX-15,posY+5);
    line(posX-15,posY-13,posX-15,posY+13);
    line(posX-15,posY-13,posX+3,posY-13);
    line(posX-15,posY+13,posX+3,posY+13);
    arc(posX+3,posY,25,26,PI+HALF_PI,TWO_PI+HALF_PI);
    line(posX+15.5,posY,posX+30,posY);
    inputNodes.get(0).display();
    inputNodes.get(1).display();
    outputNode.display();
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
    setBackground(getOutputState());
    drawOutline();
    stroke(0);
    noFill();
    line(posX-30,posY-5,posX-15,posY-5);
    line(posX-30,posY+5,posX-15,posY+5);
    arc(posX-20,posY,10,25,PI+HALF_PI,TWO_PI+HALF_PI);
    curve(posX-100,posY,posX-20,posY-12.5,posX+15.5,posY,posX+50,posY+50);
    curve(posX-100,posY,posX-20,posY+12.5,posX+15.5,posY,posX+50,posY-50);
    line(posX+15.5,posY,posX+30,posY);
    inputNodes.get(0).display();
    inputNodes.get(1).display();
    outputNode.display();
  }
}

class ExclusiveOrGate extends LogicGate {

  ExclusiveOrGate(float positionX, float positionY) {
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
    if ((inputNodes.get(0).getState() && !inputNodes.get(1).getState()) || (!inputNodes.get(0).getState() && inputNodes.get(1).getState())) {
      setOutputState(true);
    } else {
      setOutputState(false);
    }
  }

  void display() {
    setBackground(getOutputState());
    drawOutline();
    stroke(0);
    noFill();
    line(posX-30,posY-5,posX-15,posY-5);
    line(posX-30,posY+5,posX-15,posY+5);
    arc(posX-25,posY,10,23,PI+HALF_PI,TWO_PI+HALF_PI);
    arc(posX-20,posY,10,25,PI+HALF_PI,TWO_PI+HALF_PI);
    curve(posX-100,posY,posX-20,posY-12.5,posX+15.5,posY,posX+50,posY+50);
    curve(posX-100,posY,posX-20,posY+12.5,posX+15.5,posY,posX+50,posY-50);
    line(posX+15.5,posY,posX+30,posY);
    inputNodes.get(0).display();
    inputNodes.get(1).display();
    outputNode.display();
  }
}

class NorGate extends LogicGate {

  NorGate(float positionX, float positionY) {
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
      setOutputState(false);
    } else {
      setOutputState(true);
    }
  }

  void display() {
    setBackground(getOutputState());
    drawOutline();
    stroke(0);
    noFill();
    line(posX-30,posY-5,posX-15,posY-5);
    line(posX-30,posY+5,posX-15,posY+5);
    arc(posX-20,posY,10,25,PI+HALF_PI,TWO_PI+HALF_PI);
    curve(posX-100,posY,posX-20,posY-12.5,posX+15.5,posY,posX+50,posY+50);
    curve(posX-100,posY,posX-20,posY+12.5,posX+15.5,posY,posX+50,posY-50);
    ellipse(posX+20.5,posY,10,10);
    line(posX+25.5,posY,posX+32.5,posY);
    inputNodes.get(0).display();
    inputNodes.get(1).display();
    outputNode.display();
  }
}

class NandGate extends LogicGate {

  NandGate(float positionX, float positionY) {
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
      setOutputState(false);
    } else {
      setOutputState(true);
    }
  }

  void display() {
    setBackground(getOutputState());
    drawOutline();
    stroke(0);
    noFill();
    line(posX-30,posY-5,posX-15,posY-5);
    line(posX-30,posY+5,posX-15,posY+5);
    line(posX-15,posY-13,posX-15,posY+13);
    line(posX-15,posY-13,posX+3,posY-13);
    line(posX-15,posY+13,posX+3,posY+13);
    arc(posX+3,posY,25,26,PI+HALF_PI,TWO_PI+HALF_PI);
    ellipse(posX+20.5,posY,10,10);
    line(posX+25.5,posY,posX+32.5,posY);
    inputNodes.get(0).display();
    inputNodes.get(1).display();
    outputNode.display();
  }
}
