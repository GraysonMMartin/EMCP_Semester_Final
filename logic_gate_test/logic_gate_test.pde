import processing.pdf.*;
import controlP5.*;

OutputNode activeOutput = null;
InputNode activeInput = null;
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
ArrayList<ArrayList> logicGates = new ArrayList<ArrayList>();
float currentDropdownSelection;
boolean record;

void setup() {
  size(1200,850);
  background(255);
  cp5 = new ControlP5(this);
  inputGates.add(new InputGate(75,height/2));
  outputGates.add(new OutputGate(width-340,height/2));
  setupControls();
  logicGates.add(inputGates);
  logicGates.add(andGates);
  logicGates.add(orGates);
  logicGates.add(outputGates);
  logicGates.add(notGates);
  logicGates.add(exclusiveOrGates);
  logicGates.add(norGates);
  logicGates.add(nandGates);
}

void draw() {
  if (record) {
    beginRecord(PDF, str(month())+"-"+str(day())+"_"+str(hour())+"-"+str(minute())+".pdf");
  }
  background(255);
  update();
  if (record) {
    endRecord();
    record = false;
  }
}

void mouseReleased() {
  for(InputGate inputGate : inputGates){
    inputGate.switchState();
    if(inputGate.outputNode.isClicked()){
      activeOutput = inputGate.outputNode;
    }
  }
  for(OutputGate outputGate : outputGates){
    for(InputNode inputNode: outputGate.inputNodes){
      if(inputNode.isClicked()){
        activeInput = inputNode;
      }
    }
  }
  for(AndGate andGate : andGates){
    for(InputNode inputNode: andGate.inputNodes){
      if(inputNode.isClicked()){
        activeInput = inputNode;
      }
    }
    if(andGate.outputNode.isClicked()){
      activeOutput = andGate.outputNode;
    }
  }
  for(NandGate nandGate : nandGates){
    for(InputNode inputNode: nandGate.inputNodes){
      if(inputNode.isClicked()){
        activeInput = inputNode;
      }
    }
    if(nandGate.outputNode.isClicked()){
      activeOutput = nandGate.outputNode;
    }
  }
  for(OrGate orGate : orGates){
    for(InputNode inputNode: orGate.inputNodes){
      if(inputNode.isClicked()){
        activeInput = inputNode;
      }
    }
    if(orGate.outputNode.isClicked()){
      activeOutput = orGate.outputNode;
    }
  }
  for(ExclusiveOrGate xorGate : exclusiveOrGates){
    for(InputNode inputNode: xorGate.inputNodes){
      if(inputNode.isClicked()){
        activeInput = inputNode;
      }
    }
    if(xorGate.outputNode.isClicked()){
      activeOutput = xorGate.outputNode;
    }
  }
  for(NorGate norGate : norGates){
    for(InputNode inputNode: norGate.inputNodes){
      if(inputNode.isClicked()){
        activeInput = inputNode;
      }
    }
    if(norGate.outputNode.isClicked()){
      activeOutput = norGate.outputNode;
    }
  }
  for(NotGate notGate : notGates){
    for(InputNode inputNode : notGate.inputNodes){
      if(inputNode.isClicked()){
        activeInput = inputNode;
      }
    }
    if(notGate.outputNode.isClicked()){
      activeOutput = notGate.outputNode;
    }
  }
}

void controlEvent(ControlEvent theControlEvent){
  if(theControlEvent.isFrom(dropdownList)){
    currentDropdownSelection = theControlEvent.getValue();
  }
  if(theControlEvent.isFrom(addGateBtn)){
    println("add gate",currentDropdownSelection);
    addGate(currentDropdownSelection);
  }
  if(theControlEvent.isFrom(pdfBtn)){
    record = true;
  }
}

void addGate(float dropdownSelection){
  if(dropdownSelection == 0){
    inputGates.add(new InputGate(100,100));
  }
  if(dropdownSelection == 1){
    outputGates.add(new OutputGate(100,100));
  }
  if(dropdownSelection == 2){
    andGates.add(new AndGate(100,100));
  }
  if(dropdownSelection == 3){
    orGates.add(new OrGate(100,100));
  }
  if(dropdownSelection == 4){
    notGates.add(new NotGate(100,100));
  }
  if(dropdownSelection == 5){
    exclusiveOrGates.add(new ExclusiveOrGate(100,100));
  }
  if(dropdownSelection == 6){
    norGates.add(new NorGate(100,100));
  }
  if(dropdownSelection == 7){
    nandGates.add(new NandGate(100,100));
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
  for (NotGate notGate : notGates){
    notGate.updateOutputState();
    notGate.display();
  }
  for (OutputGate outputGate : outputGates) {
    outputGate.display();
  }

  if(activeInput != null && activeOutput != null){
    activeOutput.connect(activeInput);
    activeInput = null;
    activeOutput = null;
  }
}

void checkGatesPressed() {
  for (InputGate inputGate : inputGates) {
    if (inputGate.isClicked()) {
      inputGate.move(mouseX, mouseY);
    }
  }
  for (AndGate andGate : andGates) {
    if (andGate.isClicked()) {
      andGate.move(mouseX, mouseY);
    }
  }
  for (NandGate nandGate : nandGates) {
    if (nandGate.isClicked()) {
      nandGate.move(mouseX, mouseY);
    }
  }
  for (OrGate orGate : orGates) {
    if (orGate.isClicked()) {
      orGate.move(mouseX, mouseY);
    }
  }
  for (ExclusiveOrGate xorGate : exclusiveOrGates) {
    if (xorGate.isClicked()) {
      xorGate.move(mouseX, mouseY);
    }
  }
  for (NorGate norGate : norGates) {
    if (norGate.isClicked()) {
      norGate.move(mouseX, mouseY);
    }
  }
  for (NotGate notGate: notGates){
    if(notGate.isClicked()){
      notGate.move(mouseX,mouseY);
    }
  }
  for (OutputGate outputGate : outputGates) {
    if (outputGate.isClicked()) {
      outputGate.move(mouseX, mouseY);
    }
  }
}

void setupControls(){
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
     
  addGateBtn = cp5.addButton("add")
    .setValue(0)
    .setPosition(width-240,250)
    .setSize(60,40)
    ;
    
  pdfBtn = cp5.addButton("savePDF")
    .setValue(0)
    .setPosition(width-100,height-100)
    .setSize(60,40)
    ;
}
