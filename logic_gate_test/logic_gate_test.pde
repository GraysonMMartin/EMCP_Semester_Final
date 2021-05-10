import processing.pdf.*;
import controlP5.*;

OutputNode activeOutput = null;
InputNode activeInput = null;
InputGate activeInputGate = null;
AndGate activeAnd = null;
OrGate activeOr = null;
OutputGate activeOutputGate = null;
NotGate activeNot = null;
ExclusiveOrGate activeExclusiveOr = null;
NorGate activeNor = null;
NandGate activeNand = null;
ControlP5 cp5;
ScrollableList dropdownList;
Button addGateBtn, pdfBtn;
ArrayList<InputGate> inputGates = new ArrayList<InputGate>();
ArrayList<AndGate> andGates = new ArrayList<AndGate>();
ArrayList<OrGate> orGates = new ArrayList<OrGate>();
ArrayList<OutputGate> outputGates = new ArrayList<OutputGate>();
ArrayList<NotGate> notGates = new ArrayList<NotGate>();
ArrayList<ExclusiveOrGate> exclusiveOrGates = new ArrayList<ExclusiveOrGate>();
ArrayList<NorGate> norGates = new ArrayList<NorGate>();
ArrayList<NandGate> nandGates = new ArrayList<NandGate>();
float currentDropdownSelection;
boolean record;

void setup() {
  size(1200, 850);
  background(255);
  //create ControlP5 object
  cp5 = new ControlP5(this);
  //add an initial input and output gate
  inputGates.add(new InputGate(75, height/2));
  outputGates.add(new OutputGate(width-340, height/2));
  setupControls();
}

void draw() {
  //this program is a logic gate simulator
  if (record) {
    //if recording, save pdf
    beginRecord(PDF, str(month())+"-"+str(day())+"_"+str(hour())+"-"+str(minute())+".pdf");
  }
  background(255);
  update();
  if (record) {
    //stop recording after saving one pdf
    endRecord();
    record = false;
  }
}

void mouseReleased() {
  //check if an input or output node was selected to begin with
  boolean inputWasNull, outputWasNull;
  if (activeInput == null) {
    inputWasNull = true;
  } else {
    inputWasNull = false;
  }
  if (activeOutput == null) {
    outputWasNull = true;
  } else {
    outputWasNull = false;
  }
  for (InputGate inputGate : inputGates) {
    inputGate.switchState();
    if (inputGate.outputNode.isClicked()) {
      activeOutput = inputGate.outputNode;
    }
  }
  for (OutputGate outputGate : outputGates) {
    for (InputNode inputNode : outputGate.inputNodes) {
      if (inputNode.isClicked()) {
        activeInput = inputNode;
      }
    }
  }
  for (AndGate andGate : andGates) {
    for (InputNode inputNode : andGate.inputNodes) {
      if (inputNode.isClicked()) {
        activeInput = inputNode;
      }
    }
    if (andGate.outputNode.isClicked()) {
      activeOutput = andGate.outputNode;
    }
  }
  for (NandGate nandGate : nandGates) {
    for (InputNode inputNode : nandGate.inputNodes) {
      if (inputNode.isClicked()) {
        activeInput = inputNode;
      }
    }
    if (nandGate.outputNode.isClicked()) {
      activeOutput = nandGate.outputNode;
    }
  }
  for (OrGate orGate : orGates) {
    for (InputNode inputNode : orGate.inputNodes) {
      if (inputNode.isClicked()) {
        activeInput = inputNode;
      }
    }
    if (orGate.outputNode.isClicked()) {
      activeOutput = orGate.outputNode;
    }
  }
  for (ExclusiveOrGate xorGate : exclusiveOrGates) {
    for (InputNode inputNode : xorGate.inputNodes) {
      if (inputNode.isClicked()) {
        activeInput = inputNode;
      }
    }
    if (xorGate.outputNode.isClicked()) {
      activeOutput = xorGate.outputNode;
    }
  }
  for (NorGate norGate : norGates) {
    for (InputNode inputNode : norGate.inputNodes) {
      if (inputNode.isClicked()) {
        activeInput = inputNode;
      }
    }
    if (norGate.outputNode.isClicked()) {
      activeOutput = norGate.outputNode;
    }
  }
  for (NotGate notGate : notGates) {
    for (InputNode inputNode : notGate.inputNodes) {
      if (inputNode.isClicked()) {
        activeInput = inputNode;
      }
    }
    if (notGate.outputNode.isClicked()) {
      activeOutput = notGate.outputNode;
    }
  }
  //if a node wasn't clicked, unselect selected node
  if (!inputWasNull && activeOutput == null) {
    activeInput = null;
  }
  if (!outputWasNull && activeInput == null) {
    activeOutput = null;
  }
  //reset active gates
  activeInputGate = null;
  activeOutputGate = null;
  activeAnd = null;
  activeOr = null;
  activeNot = null;
  activeExclusiveOr = null;
  activeNor = null;
  activeNand = null;
}

void controlEvent(ControlEvent theControlEvent) {
  //handles ControlP5 actions
  if (theControlEvent.isFrom(dropdownList)) {
    currentDropdownSelection = theControlEvent.getValue();
  }
  if (theControlEvent.isFrom(addGateBtn)) {
    addGate(currentDropdownSelection);
  }
  if (theControlEvent.isFrom(pdfBtn)) {
    record = true;
  }
}

void addGate(float dropdownSelection) {
  //add the gate coinciding with the position in the scrollable list
  if (dropdownSelection == 0) {
    inputGates.add(new InputGate(100, 100));
  }
  if (dropdownSelection == 1) {
    outputGates.add(new OutputGate(100, 100));
  }
  if (dropdownSelection == 2) {
    andGates.add(new AndGate(100, 100));
  }
  if (dropdownSelection == 3) {
    orGates.add(new OrGate(100, 100));
  }
  if (dropdownSelection == 4) {
    notGates.add(new NotGate(100, 100));
  }
  if (dropdownSelection == 5) {
    exclusiveOrGates.add(new ExclusiveOrGate(100, 100));
  }
  if (dropdownSelection == 6) {
    norGates.add(new NorGate(100, 100));
  }
  if (dropdownSelection == 7) {
    nandGates.add(new NandGate(100, 100));
  }
}
void update() {
  if (mousePressed) {
    checkGatesPressed();
  }
  for (InputGate inputGate : inputGates) {
    inputGate.update();
    inputGate.display();
  }
  for (AndGate andGate : andGates) {
    andGate.updateOutputState();
    andGate.display();
  }
  for (NandGate nandGate : nandGates) {
    nandGate.updateOutputState();
    nandGate.display();
  }
  for (OrGate orGate : orGates) {
    orGate.updateOutputState();
    orGate.display();
  }
  for (ExclusiveOrGate xorGate : exclusiveOrGates) {
    xorGate.updateOutputState();
    xorGate.display();
  }
  for (NorGate norGate : norGates) {
    norGate.updateOutputState();
    norGate.display();
  }
  for (NotGate notGate : notGates) {
    notGate.updateOutputState();
    notGate.display();
  }
  for (OutputGate outputGate : outputGates) {
    outputGate.display();
  }

  if (activeInput != null && activeOutput != null) {
    //connect input and output nodes if both are selected
    activeOutput.connect(activeInput);
    //reset input and output nodes
    activeInput = null;
    activeOutput = null;
  }
}

void checkGatesPressed() {
  for (InputGate inputGate : inputGates) {
    if (inputGate.isClicked() && !otherGatePressed()) {
      activeInputGate = inputGate;
    }
  }
  for (AndGate andGate : andGates) {
    if (andGate.isClicked() && !otherGatePressed()) {
      activeAnd = andGate;
    }
  }
  for (NandGate nandGate : nandGates) {
    if (nandGate.isClicked() && !otherGatePressed()) {
      activeNand = nandGate;
    }
  }
  for (OrGate orGate : orGates) {
    if (orGate.isClicked() &&!otherGatePressed()) {
      activeOr = orGate;
    }
  }
  for (ExclusiveOrGate xorGate : exclusiveOrGates) {
    if (xorGate.isClicked() && !otherGatePressed()) {
      activeExclusiveOr = xorGate;
    }
  }
  for (NorGate norGate : norGates) {
    if (norGate.isClicked() && !otherGatePressed()) {
      activeNor = norGate;
    }
  }
  for (NotGate notGate : notGates) {
    if (notGate.isClicked() &&!otherGatePressed()) {
      activeNot = notGate;
    }
  }
  for (OutputGate outputGate : outputGates) {
    if (outputGate.isClicked() && !otherGatePressed()) {
      activeOutputGate = outputGate;
    }
  }
  checkDeleteGate();
  moveActiveGate();
}

boolean otherGatePressed() {
  //returns a boolean indicating if another gate is active
  if (activeInputGate == null && activeOutputGate == null && activeAnd == null && activeOr == null && activeNot == null && activeNor == null && activeNand == null && activeExclusiveOr == null) {
    return false;
  } else {
    return true;
  }
}

void moveActiveGate() {
  //moves the active gate centered at the mouse's position
  if (activeInputGate != null) {
    activeInputGate.move(mouseX, mouseY);
  }
  if (activeOutputGate != null) {
    activeOutputGate.move(mouseX, mouseY);
  }
  if (activeAnd != null) {
    activeAnd.move(mouseX, mouseY);
  }
  if (activeOr != null) {
    activeOr.move(mouseX, mouseY);
  }
  if (activeNot != null) {
    activeNot.move(mouseX, mouseY);
  }
  if (activeNor != null) {
    activeNor.move(mouseX, mouseY);
  }
  if (activeNand != null) {
    activeNand.move(mouseX, mouseY);
  }
  if (activeExclusiveOr != null) {
    activeExclusiveOr.move(mouseX, mouseY);
  }
}

void checkDeleteGate() {
  //checks if the delete button is clicked, disconnects all connections to the gate, and deletes the gate
  if (activeInputGate != null) {
    if (activeInputGate.delete()) {
      inputGates.remove(activeInputGate);
      activeInputGate = null;
    }
  }
  if (activeOutputGate != null) {
    if (activeOutputGate.delete()) {
      activeOutputGate.disconnect();
      outputGates.remove(activeOutputGate);
      activeOutputGate = null;
    }
  }
  if (activeAnd != null) {
    if (activeAnd.delete()) {
      activeAnd.disconnect();
      andGates.remove(activeAnd);
      activeAnd = null;
    }
  }
  if (activeOr != null) {
    if (activeOr.delete()) {
      activeOr.disconnect();
      orGates.remove(activeOr);
      activeOr = null;
    }
  }
  if (activeNot != null) {
    if (activeNot.delete()) {
      activeNot.disconnect();
      notGates.remove(activeNot);
      activeNot = null;
    }
  }
  if (activeNor != null) {
    if (activeNor.delete()) {
      activeNor.disconnect();
      norGates.remove(activeNor);
      activeNor = null;
    }
  }
  if (activeNand != null) {
    if (activeNand.delete()) {
      activeNand.disconnect();
      nandGates.remove(activeNand);
      activeNand = null;
    }
  }
  if (activeExclusiveOr != null) {
    if (activeExclusiveOr.delete()) {
      activeExclusiveOr.disconnect();
      exclusiveOrGates.remove(activeExclusiveOr);
      activeExclusiveOr = null;
    }
  }
}

void setupControls() {
  //setup ControlP5 controls

  //setup scrollable list to choose gates
  ArrayList<String> dropdownOptions = new ArrayList<String>();
  dropdownOptions.add("Input");
  dropdownOptions.add("Output");
  dropdownOptions.add("AND");
  dropdownOptions.add("OR");
  dropdownOptions.add("NOT");
  dropdownOptions.add("XOR");
  dropdownOptions.add("NOR");
  dropdownOptions.add("NAND");
  dropdownList = cp5.addScrollableList("dropdown")
    .setPosition(width-240, 40)
    .setSize(200, 200)
    .setBarHeight(40)
    .setItemHeight(40)
    .addItems(dropdownOptions)
    .setValue(0)
    .setOpen(false)
    ;

  currentDropdownSelection = 0;

  //setup add gate button
  addGateBtn = cp5.addButton("add")
    .setValue(0)
    .setPosition(width-240, 250)
    .setSize(60, 40)
    ;

  //setup save PDF button
  pdfBtn = cp5.addButton("Save PDF")
    .setValue(0)
    .setPosition(width-100, height-100)
    .setSize(60, 40)
    ;
}
