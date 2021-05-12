class Node {
  //parent node class for input and output nodes

  float positionX, positionY;
  float nodeRadius = 5;
  boolean state = false;
  boolean isSelected = false;

  Node(float positionX, float positionY) {
    this.positionX = positionX;
    this.positionY = positionY;
  }

  void setState(boolean state) {
    //set the node's T/F state
    this.state = state;
  }

  void move(float newX, float newY) {
    //move the node to newX, newY
    positionX = newX;
    positionY = newY;
  }

  void unselect() {
    //unselect the node
    isSelected = false;
  }

  boolean getState() {
    //returns the node's T/F state
    return state;
  }

  float getPositionX() {
    //return's the node's x position
    return positionX;
  }

  float getPositionY() {
    //returns the node's y position
    return positionY;
  }

  boolean isClicked() {
    //returns a bool indicating if a node was selected
    //changes a node's selected state
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
  //class that representes an input node to a logic gate

  OutputNode connectedOutput = null;
  float offsetY;
  InputNode(float positionX, float positionY, float offsetY) {
    super(positionX, positionY);
    this.offsetY = offsetY;
  }

  void display() {
    //displays the node
    setState(false);
    if (isSelected) {
      //fill with red if node is selected
      fill(255, 0, 0);
    } else {
      fill(0);
    }
    ellipse(positionX, positionY, 2*nodeRadius, 2*nodeRadius);
  }

  void setConnectedOutput(OutputNode newOutput) {
    //tell the input node which output node object it is connected to
    connectedOutput = newOutput;
  }

  void disconnect(Wire connection) {
    //stop drawing the connection
    println("disconnect in input class");
    connection.undraw();
    connectedOutput = null;
  }

  float getOffsetY() {
    //returns the node's offset from the center of its logic gate
    return 50-offsetY;
  }
}

class OutputNode extends Node {
  //class that represents an output node for a logic gate

  InputNode connectedInput;
  Wire connection;

  OutputNode(float positionX, float positionY) {
    super(positionX, positionY);
    connectedInput = null;
  }

  void connect(InputNode inputNode) {
    println("connect");
    //connect to an input node
    connectedInput = inputNode;
    connectedInput.setConnectedOutput(this);
    //create a wire connection between the nodes
    connection = new Wire(positionX, positionY, connectedInput.getPositionX(), connectedInput.getPositionY(), connectedInput.getOffsetY());
    //set the input node's state to this node's state
    connectedInput.setState(getState());
    //unselect the nodes upon connection
    connectedInput.unselect();
    unselect();
  }

  void disconnect() {
    println("disconnect in output class");
    //disconnect from an input node

    //reset the input node's state to false
    connectedInput.setState(false);
    //undraw the connection
    connection.undraw();
    connectedInput = null;
  }

  void display() {
    //displays the output node
    if (isSelected) {
      //fill with red if it is selected
      fill(255, 0, 0);
    } else {
      fill(0);
    }
    ellipse(positionX, positionY, 2*nodeRadius, 2*nodeRadius);
    if (connectedInput != null) {
      //if there is a connected input, draw the connection
      
      //update the connected input's state
      connectedInput.setState(getState());
      //update the node positions for the wire
      connection.update(positionX, positionY, connectedInput.getPositionX(), connectedInput.getPositionY());
      connection.display();
    }
  }
}
