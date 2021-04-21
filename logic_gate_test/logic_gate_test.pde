import processing.pdf.*;
import controlP5.*;

InputGate inputOne, inputTwo;
OutputGate outputOne;
AndGate andOne, andTwo;
OrGate orOne, orTwo;
OutputNode testNode;
InputNode testNodeTwo;
ControlP5 cp5;
ArrayList<InputGate> inputGates = new ArrayList<InputGate>();
boolean record;

void setup() {
  size(900, 700);
  background(255);
  cp5 = new ControlP5(this);
  inputOne = new InputGate(50, 100, cp5);
  inputTwo = new InputGate(2, 2, cp5);
  outputOne = new OutputGate(250, 400);
  andOne = new AndGate(500, 500);
  andTwo = new AndGate(40, 20);
  orOne = new OrGate(3, 3);
  orTwo = new OrGate(222, 60);
  testNode = new OutputNode(66,66);
  testNodeTwo = new InputNode(100,500,0);
  //cp5.addToggle("toggleValue").setPosition(20,25).setSize(50,20).setMode(ControlP5.SWITCH);
}

void draw() {
  if(record){
    beginRecord(PDF,"frame-####.pdf");
  }
  background(255);
  inputOne.display();
  outputOne.display();
  andOne.display();
  orTwo.display();
  rect(width/2-50,height/2-50,100,100);
  andOne.updateOutputState();
  update();
  if(record){
    endRecord();
    record = false;
  }
}

void mouseReleased() {
  testNode.connect(testNodeTwo);
  if(mouseX < width/2+50 && mouseX > width/2-50 && mouseY < height/2 + 50 && mouseY > height/2-50){
    inputGates.add(new InputGate(0,0,cp5));
    //record = true;
    
  }
}

void update() {
  if (mousePressed) {
    checkGatesPressed();
  }
  for(InputGate inputGate : inputGates){
    inputGate.display();
  }
}

void checkGatesPressed() {
  for(InputGate inputGate : inputGates){
    if(inputGate.isClicked()){
      inputGate.move(mouseX,mouseY);
    }
  }
  if (inputOne.isClicked()) {
    inputOne.move(mouseX, mouseY);
  }
  if (outputOne.isClicked()) {
    outputOne.move(mouseX, mouseY);
  }
  if (andOne.isClicked()) {
    andOne.move(mouseX, mouseY);
  }
  if (orTwo.isClicked()) {
    orTwo.move(mouseX, mouseY);
  }
}
