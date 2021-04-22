import processing.pdf.*;
import controlP5.*;

OutputNode testNode;
InputNode testNodeTwo;
ControlP5 cp5;
ScrollableList dropdownList;
Button addGateBtn, pdfBtn;
ArrayList<InputGate> inputGates = new ArrayList<InputGate>();
ArrayList<AndGate> andGates = new ArrayList<AndGate>();
ArrayList<OrGate> orGates = new ArrayList<OrGate>();
ArrayList<OutputGate> outputGates = new ArrayList<OutputGate>();
float currentDropdownSelection;
boolean record;

void setup() {
  size(1200,850);
  background(255);
  cp5 = new ControlP5(this);
  testNode = new OutputNode(66, 66);
  testNodeTwo = new InputNode(100, 500, 0);
  inputGates.add(new InputGate(75,height/2));
  outputGates.add(new OutputGate(width-340,height/2));
  setupControls();
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
  //testNode.connect(testNodeTwo);
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
}
void update() {
  if (mousePressed) {
    checkGatesPressed();
  }
  for (InputGate inputGate : inputGates) {
    inputGate.display();
  }
  for (AndGate andGate : andGates) {
    andGate.display();
  }
  for (OrGate orGate : orGates) {
    orGate.display();
  }
  for (OutputGate outputGate : outputGates) {
    outputGate.display();
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
  for (OrGate orGate : orGates) {
    if (orGate.isClicked()) {
      orGate.move(mouseX, mouseY);
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
