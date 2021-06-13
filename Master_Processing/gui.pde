public void slider1_change1(GSlider source, GEvent event) { //_CODE_:slider1:790724:
  //println("slider1 - GSlider event occured " + System.currentTimeMillis()%10000000 );
  myPort.clear();
  myPort.write("0,"+slider1.getValueI()+"\n");

} //_CODE_:slider1:790724:

public void dropList1_click1(GDropList source, GEvent event) { //_CODE_:dropList1:697391:
  //println("dropList1 - GDropList event occured " + System.currentTimeMillis()%10000000 );
  int i = dropList1.getSelectedIndex();
  myPort.clear();
  myPort.stop();
  myPort = new Serial(this, Serial.list()[i], 9600);
  myPort.bufferUntil('\n');
} //_CODE_:dropList1:697391:

public void slider2_change1(GSlider source, GEvent event) { //_CODE_:slider2:752459:
  //println("slider2 - GSlider event occured " + System.currentTimeMillis()%10000000 );
  myPort.clear();
  myPort.write("1,"+slider2.getValueI()+"\n");
} //_CODE_:slider2:752459:

public void slider3_change1(GSlider source, GEvent event) { //_CODE_:slider3:489757:
  //println("slider3 - GSlider event occured " + System.currentTimeMillis()%10000000 );
  myPort.clear();
  myPort.write("2,"+slider3.getValueI()+"\n");
} //_CODE_:slider3:489757:

public void slider4_change1(GSlider source, GEvent event) { //_CODE_:slider4:801509:
  //println("slider4 - GSlider event occured " + System.currentTimeMillis()%10000000 );
  myPort.clear();
  myPort.write("3,"+slider4.getValueI()+"\n");
} //_CODE_:slider4:801509:

public void slider5_change1(GSlider source, GEvent event) { //_CODE_:slider5:834674:
  //println("slider5 - GSlider event occured " + System.currentTimeMillis()%10000000 );
  myPort.clear();
  myPort.write("4,"+slider5.getValueI()+"\n");
} //_CODE_:slider5:834674:

public void slider2d1_change1(GSlider2D source, GEvent event) { //_CODE_:slider2d1:750043:
  //println("slider2d1 - GSlider2D event occured " + System.currentTimeMillis()%10000000 );
  float x = slider2d1.getValueXI();
  float y = slider2d1.getValueYI();
  label5.setText(""+x);
  label6.setText(""+y);
  float z = slider1.getValueI();
  int g = slider5.getValueI();
  float w = slider6.getValueI();
  Arm(x,y,z,g,w,90);
} //_CODE_:slider2d1:750043:

public void slider6_change1(GSlider source, GEvent event) { //_CODE_:slider6:431756:
  //println("slider6 - GSlider event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:slider6:431756:

public void button1_click1(GButton source, GEvent event) { //_CODE_:button1:289466:
  selected_file="normalstance.csv";
  PLAYBACK=true;
} //_CODE_:button1:289466:

public void button2_click1(GButton source, GEvent event) { //_CODE_:button2:319793:
  selected_file="sad.csv";
  PLAYBACK=true;
} //_CODE_:button2:319793:

public void button3_click1(GButton source, GEvent event) { //_CODE_:button3:218967:
  selected_file="recording.csv";
  PLAYBACK=true;
} //_CODE_:button3:218967:

public void button4_click1(GButton source, GEvent event) { //_CODE_:button4:923212:
  println("button4 - GButton event occured " + System.currentTimeMillis()%10000000 );
  myPort.clear();
  myPort.write("8,0,100,0\n");
  myPort.write("9,0,100,0\n");
  
} //_CODE_:button4:923212:

public void button5_click1(GButton source, GEvent event) { //_CODE_:button5:467161:
  println("button5 - GButton event occured " + System.currentTimeMillis()%10000000 );
  myPort.clear();
  myPort.write("8,0,0,0\n");
  myPort.write("9,0,0,0\n");
  
} //_CODE_:button5:467161:

public void button6_click1(GButton source, GEvent event) { //_CODE_:button6:927708:
  println("button6 - GButton event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:button6:927708:

public void button7_click1(GButton source, GEvent event) { //_CODE_:button7:386892:
  println("button7 - GButton event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:button7:386892:

public void button8_click1(GButton source, GEvent event) { //_CODE_:button8:478806:
  println("button8 - GButton event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:button8:478806:

public void button9_click1(GButton source, GEvent event) { //_CODE_:button9:853082:
  println("button9 - GButton event occured " + System.currentTimeMillis()%10000000 );
} //_CODE_:button9:853082:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  if(frame != null)
    frame.setTitle("Controlador de Lampara");
  slider1 = new GSlider(this, 366, 15, 350, 75, 30.0);
  slider1.setShowValue(true);
  slider1.setShowLimits(true);
  slider1.setLimits(90.0, 0.0, 180.0);
  slider1.setEasing(10.0);
  slider1.setNumberFormat(G4P.INTEGER, 0);
  slider1.setOpaque(false);
  slider1.addEventHandler(this, "slider1_change1");
  dropList1 = new GDropList(this, 134, 9, 195, 243, 9);
  dropList1.setItems(loadStrings("list_697391"), 0);
  dropList1.addEventHandler(this, "dropList1_click1");
  slider2 = new GSlider(this, 366, 92, 350, 75, 30.0);
  slider2.setShowValue(true);
  slider2.setShowLimits(true);
  slider2.setLimits(90.0, 0.0, 180.0);
  slider2.setEasing(10.0);
  slider2.setNumberFormat(G4P.INTEGER, 0);
  slider2.setOpaque(false);
  slider2.addEventHandler(this, "slider2_change1");
  slider3 = new GSlider(this, 366, 168, 350, 75, 30.0);
  slider3.setShowValue(true);
  slider3.setShowLimits(true);
  slider3.setLimits(90.0, 0.0, 180.0);
  slider3.setEasing(10.0);
  slider3.setNumberFormat(G4P.INTEGER, 0);
  slider3.setOpaque(false);
  slider3.addEventHandler(this, "slider3_change1");
  slider4 = new GSlider(this, 365, 244, 350, 75, 30.0);
  slider4.setShowValue(true);
  slider4.setShowLimits(true);
  slider4.setLimits(90.0, 0.0, 180.0);
  slider4.setEasing(10.0);
  slider4.setNumberFormat(G4P.INTEGER, 0);
  slider4.setOpaque(false);
  slider4.addEventHandler(this, "slider4_change1");
  slider5 = new GSlider(this, 366, 321, 350, 75, 30.0);
  slider5.setShowValue(true);
  slider5.setShowLimits(true);
  slider5.setLimits(90.0, 0.0, 180.0);
  slider5.setEasing(10.0);
  slider5.setNumberFormat(G4P.INTEGER, 0);
  slider5.setOpaque(false);
  slider5.addEventHandler(this, "slider5_change1");
  slider2d1 = new GSlider2D(this, 26, 148, 305, 153);
  slider2d1.setLimitsX(75.0, 0.0, 175.0);
  slider2d1.setLimitsY(75.0, 0.0, 200.0);
  slider2d1.setNumberFormat(G4P.DECIMAL, 0);
  slider2d1.setOpaque(true);
  slider2d1.addEventHandler(this, "slider2d1_change1");
  label1 = new GLabel(this, 22, 9, 103, 27);
  label1.setText("Serial Port");
  label1.setTextBold();
  label1.setOpaque(true);
  label2 = new GLabel(this, 26, 313, 133, 20);
  label2.setText("Distance from origin:");
  label2.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  label2.setOpaque(false);
  label3 = new GLabel(this, 96, 340, 56, 17);
  label3.setText("X(mm):");
  label3.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  label3.setOpaque(false);
  label4 = new GLabel(this, 72, 363, 80, 20);
  label4.setText("Y(mm):");
  label4.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  label4.setOpaque(false);
  label5 = new GLabel(this, 159, 340, 80, 20);
  label5.setText("0");
  label5.setOpaque(false);
  label6 = new GLabel(this, 158, 365, 80, 20);
  label6.setText("0");
  label6.setOpaque(false);
  slider6 = new GSlider(this, 366, 441, 350, 75, 30.0);
  slider6.setShowValue(true);
  slider6.setShowLimits(true);
  slider6.setLimits(0.0, -90.0, 90.0);
  slider6.setEasing(10.0);
  slider6.setNumberFormat(G4P.INTEGER, 0);
  slider6.setOpaque(false);
  slider6.addEventHandler(this, "slider6_change1");
  button1 = new GButton(this, 32, 536, 80, 30);
  button1.setText("Normal");
  button1.addEventHandler(this, "button1_click1");
  button2 = new GButton(this, 124, 537, 80, 30);
  button2.setText("Sad");
  button2.addEventHandler(this, "button2_click1");
  button3 = new GButton(this, 216, 537, 80, 30);
  button3.setText("Blink");
  button3.addEventHandler(this, "button3_click1");
  button4 = new GButton(this, 33, 577, 80, 30);
  button4.setText("Yes");
  button4.addEventHandler(this, "button4_click1");
  button5 = new GButton(this, 124, 577, 80, 30);
  button5.setText("No");
  button5.addEventHandler(this, "button5_click1");
  button6 = new GButton(this, 215, 578, 80, 30);
  button6.setText("Face text");
  button6.addEventHandler(this, "button6_click1");
  label9 = new GLabel(this, 173, 443, 115, 20);
  label9.setText("Enable LeapMotion");
  label9.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  label9.setOpaque(false);
  button7 = new GButton(this, 34, 619, 80, 30);
  button7.setText("Face text");
  button7.addEventHandler(this, "button7_click1");
  button8 = new GButton(this, 125, 619, 80, 30);
  button8.setText("Face text");
  button8.addEventHandler(this, "button8_click1");
  button9 = new GButton(this, 216, 619, 80, 30);
  button9.setText("Face text");
  button9.addEventHandler(this, "button9_click1");
  label8 = new GLabel(this, 99, 442, 80, 20);
  label8.setText("Light");
  label8.setOpaque(false);
}

// Variable declarations 
// autogenerated do not edit
GSlider slider1; 
GDropList dropList1; 
GSlider slider2; 
GSlider slider3; 
GSlider slider4; 
GSlider slider5; 
GSlider2D slider2d1; 
GLabel label1; 
GLabel label2; 
GLabel label3; 
GLabel label4; 
GLabel label5; 
GLabel label6; 
GSlider slider6; 
GButton button1; 
GButton button2; 
GButton button3; 
GButton button4; 
GButton button5; 
GButton button6; 
GLabel label9; 
GButton button7; 
GButton button8; 
GButton button9; 
GLabel label8; 
