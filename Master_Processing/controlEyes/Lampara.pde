import de.voidplus.leapmotion.*;
// Need G4P library
import g4p_controls.*;
import processing.serial.*;

// Create Serial Communication
Serial myPort;
String s="";
//PImage crciberneticalogo;
LeapMotion leap;

String LeapX;
String LeapY;
String LeapZ;

//Parameter of robotic arm
//float A = 95.25; //millimeters
float A = 167.5; //distance from base to elbow
//float B = 107.95;
float B = 180; //distance from elbow to wrist (gripper in case)
//float rtod = 57.295779; //What is that?
float rtod = 50; //elements for calculate the kinematic

//Parameter of Length
int l1 = 150; //Joint 1
int l2 = 190; //Joint 2
int l3 = 160; //Joint 3

boolean sval=false;

GImageToggleButton btnToggle0;
GImageToggleButton btnToggle1;

PrintWriter output;

String fileName;
Table table;
String selected_file; //file lua chon
int selectedfilecount=0; // dem so file lua chon
 
boolean LEAPMOTION = false; //bien bat dau cho phep leap motion
boolean PLAYBACK = false; //Bien khai bao che do playback
boolean RECORD = false; //
int playback_count = 0;
long previousMillis = 0;
long previousBlinkMillis = 0;
long interval = 100; // What is that ?
boolean LAMP = false;

// Declare Kalman Filter Variable
// KalmanFilter kf;

public void settings()
{
  size(750, 700, JAVA2D); //Create a new windows form to monitor result
}
public void setup() 
{ 
  createGUI();
  //Create button using G4P library
  btnToggle0 = new GImageToggleButton(this, 133, 469); //with pixel
  btnToggle0.tag = "0";
  btnToggle1 = new GImageToggleButton(this, 183, 469); // width and length
  btnToggle1.tag = "1";
  leap = new LeapMotion(this); 
  //crciberneticalogo = loadImage("CRCibernetica509x81.png");
  //String portName = "";
  myPort = new Serial(this, "COM4", 9600); //Baudrat default 9600, COM of Master
  myPort.bufferUntil('\n');

  dropList1.setItems(Serial.list(), 0);
  fileName = getDateTime();
  //output = createWriter("data/" + "positions" + fileName + ".csv");
  //output.println("x,y,z,g,wa,wr");
}

/* Them bo loc kalman */

// class KalmanFilter 
// {
//   float q = 1.0;     // process variance
//   float r = 2.0;     // estimate of measurement variance, change to see effect

//   float xhat = 0.0;  // a posteriori estimate of x
//   float xhatminus;   // a priori estimate of x
//   float p = 1.0;     // a posteriori error estimate
//   float pminus;      // a priori error estimate
//   float kG = 0.0;    // kalman gain
//   //KalmanFilter();
//   KalmanFilter(float q, float r) 
//   {
//     q(q); //What is that ??
//     r(r);
//   }
  
//   void q(float q) 
//   {
//     this.q = q;
//   }
  
//   void r(float r) 
//   {
//     this.r = r;
//   }
  
//   float xhat() 
//   {
//     return this.xhat;
//   }

//   void predict() 
//   {
//     xhatminus = xhat;
//     pminus = p + q;
//   }

//   float correct(float x) 
//   {
//     kG = pminus / (pminus + r);
//     xhat = xhatminus + kG * (x - xhatminus);
//     p = (1 - kG) * pminus;
    
//     return xhat;
//   }
  
//   float predict_and_correct(float x) {
//     predict();
//     return correct(x);
//   }
// }

/* End of Kalman Filter */

public void draw() 
{
  background(255);
  //image(crciberneticalogo, 414, 636, 305, 48.5);
 for (Hand hand : leap.getHands())
  {
    PVector hv = hand.getIndexFinger().getRawPositionOfJointTip();
    //delay(100);
    float px = hv.x;
    float py = hv.y;
    float pz = hv.z;
    int PX = int(px);
    int PY = int(py);
    int PZ = int(pz);
    
    //Convert int to string
    
    LeapX = String.valueOf(PX);
    LeapY = String.valueOf(PY);
    LeapZ = String.valueOf(PZ);
    
    String send = LeapX.concat(",").concat(LeapY).concat(",").concat(LeapZ);
    String[] output = send.split(",");
    println(output[0]);
    println(output[1]);
    println(output[2]);
  }
  if (LEAPMOTION) 
  {
    updateLeapMotion();
  }
  updatePlayBack(); //Subprocess
  updateAnimation(); //Subprocess
  
 // updateBlink();
}

/* 
 positioning routine utilizing inverse kinematics */
/* z is base angle, y vertical distance from base, x is horizontal distance from base.*/
// Get x,y,z from function ();
// INVERSE KINEMATIC
int Arm(float x, float y, float z, float g) 
{
  
  // float A1 = atan(y/x);
  // float A2 = acos((A*A-B*B+M*M)/((A*2)*M));
  // float Elbow = acos((A*A+B*B-M*M)/((A*2)*B));
  // float Shoulder = A1 + A2;
  // Elbow = Elbow * rtod; //rtod la cai wtf gigi
  // Shoulder = Shoulder * rtod;
  // while ( (int)Elbow <= 0 || (int)Shoulder <= 0)
  //  return 1;
  //float Wris = abs(wa - Elbow - Shoulder) - 90; //Khong can quan tam luc nay lam
  // slider1.setValue(z);
  // slider2.setValue(Shoulder);
  // slider3.setValue(180-Elbow);
  // //slider4.setValue(180-Wris); //Co the se xai lai
  // slider5.setValue(g);
  //Elb.write(180 - Elbow);
   //Shldr.write(Shoulder);
   //Wrist.write(180 - Wris);
   //Base.write(z);
   //WristR.write(wr);
   //Gripper.write(g); // Voi g la kep hay k kep?

  float M = sqrt((y*y)+(x*x));
  if (M <= 0)
    return 1;
  float a = -2*l2*(l1-z);
  float theta1 = atan2(y,x);
  float b = -2*l2*(x*cos(theta1)+y*sin(theta1));
  float c = l3*l3 - (z-l1)*(z-l1) - l2*l2 - pow((x*cos(theta1) + y*sin(theta1)),2);
  float theta2 = atan2(a,b) + atan2(sqrt(a*a + b*b - c*c),c);
  float d = (l1 - z)*sin(theta2) + (x*cos(theta1)+y*sin(theta1))*cos(theta2) - l2;
  float e = (l1 - z)*cos(theta2) - (x*cos(theta1)+y*sin(theta1))*sin(theta2);
  float theta3 = atan2(e,d);
  // Set value
  slider1.setValue(theta1);
  slider2.setValue(theta2);
  slider3.setValue(theta3);
  slider5.setValue(g); //Gripper
  //Base.write(theta1);
  //Shldr.write(theta2);
  //Elb.write(theta3);
  //Gripper.write(g);

  // Print result ????????????????????????????????
  //println(theta1);
  //println(theta2);
  //println(theta3);
  //println(g);

  return 0; //That is important
}

// Event handler for image toggle buttons
public void handleToggleButtonEvents(GImageToggleButton button, GEvent event) 
  { 
  println(button + "   State: " + button.stateValue());
  if (button.tag=="1") {
    LEAPMOTION=boolean(button.stateValue());
  }
  if (button.tag=="0") {
    //toggle main light
    println("Light: " + button.stateValue());
    controlLamp(button.stateValue());
  }
}
/* Chuong trinh manual mode */
void keyPressed() {
  if (keyCode==16){//right shift
    PLAYBACK = false;
    playback_count = 0;
    selected_file="normalstance.csv";
    PLAYBACK=true;
    controlEyes(0);
    controlLamp(1);
  }
   if (keyCode==47){// forward slash
    PLAYBACK = false;
    playback_count = 0;
    selectedfilecount=selectedfilecount+1;
    if(selectedfilecount>4){
      selectedfilecount=1;
    }
    selected_file=selectedfilecount+".csv";
    PLAYBACK=true;
    controlEyes(1);
    controlLamp(0);
  }
  
  if (keyCode==32) {
    sval=!sval;
    int stateVal=int(sval);
    btnToggle0.stateValue(stateVal);
    controlLamp(stateVal);
  }
  if (keyCode==83) { // s to save coordinates to file
    println("Coordinates saved to file");
    float x = slider2d1.getValueXI();
    float y = slider2d1.getValueYI();
    float z = slider1.getValueI();
    int g = slider5.getValueI();
    float w = slider6.getValueI();
    output.println(x + "," + y + "," + z + "," + g + "," + w + "," + 90);
  }
  if (keyCode==88) {
    println("Close file"); //x to save and close file
    RECORD=false;
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    exit(); // Stops the program
  }
  if (keyCode==80) {
    println("Playback"); //p for playback
    PLAYBACK = true;
  }
  if (keyCode==78) { 
    fileName = getDateTime();
    output = createWriter("data/" + "positions" + fileName + ".csv");
    output.println("x,y,z,g,wa,wr");
    println("New position file"); //n for new file
  }
  if (keyCode==79) {
    println("Open File for Playback"); //o for open file for playback
    selectInput("Select a file to playback:", "fileSelected");
  }
  if (keyCode==82) {
    println("Record"); //r for record
    RECORD = true;
  }
}
/* Cap nhat khi bat leap motion */
void updateLeapMotion() {
  int fps = leap.getFrameRate(); //Do toc do lam tuoi leap motion
  // HANDS
  // for(Hand hand : leap.getHands()){
  ArrayList hands = leap.getHands();
  if (!hands.isEmpty()) {
    Hand hand1 = (Hand) hands.toArray()[0];
    //Hand hand2 = (Hand) hands.toArray()[1];

    //hand.draw();
    //int     hand_id          = hand.getId();
    PVector hand1_position    = hand1.getPosition();
    PVector hand1_stabilized  = hand1.getStabilizedPosition();
    //PVector hand_direction   = hand.getDirection();
    //PVector hand_dynamics    = hand.getDynamics();
    /*get roll, pitch, yaw for robot */

    // Measure information
    float   hand1_roll        = hand1.getRoll();
    float   hand1_pitch       = hand1.getPitch();
    float   hand1_yaw         = hand1.getYaw();
    float   hand1_time        = hand1.getTimeVisible();
    
    // Using Kalman Filter here
    //float roll_hat = kf.predict_and_correct(hand1_roll);
    //float pitch_hat = kf.predict_and_correct(hand1_pitch);
    //float yaw_hat = kf.predict_and_correct(hand1_yaw);
    float hand1_x = hand1_stabilized.x;  //Get X raw data
    //float hand1_xhat = kf.predict_and_correct(hand1_x);
    float hand1_y = hand1_stabilized.y;  //Get Y raw data
    //float hand1_yhat = kf.predict_and_correct(hand1_y);
    float hand1_z = hand1_stabilized.z; //Get Z raw data
    //float hand1_zhat = kf.predict_and_correct(hand1_z);
    
    //float roll_hat = kf.predict_and_correct(hand1_time);
    //float   hand2_time        = hand2.getTimeVisible();
    //PVector sphere_position  = hand.getSpherePosition();
    //float   sphere_radius    = hand.getSphereRadius();
    if (hand1_time>1.0) {
      //println("x: " +hand1_stabilized.x+" y: "+hand1_stabilized.y+" z:"+hand1_stabilized.z);
      float transHand1PosZ = map(hand1_x, 150, 450, 50, 130); //angle of base
      slider1.setValue(transHand1PosZ);
      float transHand1PosY = map(hand1_y, 300, 550, 20, 200); // from base to elbow
      slider2d1.setValueY(transHand1PosY);
      float transHand1PosX = map(hand1_z, 30, 55, 20, 175); // from elbow to wrist
      slider2d1.setValueX(transHand1PosX);
      float transHand1Roll = map(hand1_roll, 30, -30, 45, -80);
      //println("HandRoll " +hand1_roll+" OUTPUT: "+transHand1Roll);
      slider6.setValue(transHand1Roll);
      float transHand1Yaw = map(hand1_yaw, 0, 50, 50, 175);

      //println("Yaw " +hand1_yaw+" OUTPUT: "+transHand1Yaw);
      slider5.setValue(transHand1Yaw);
      // Add inverse kinematic function here

      Arm(transHand1PosX, transHand1PosY, transHand1PosZ, transHand1Roll);
       //Arm(transHand1PosX, transHand1PosY, transHand1PosZ, transHand1Roll, 1, transHand1Yaw);
      // Lack of Pitch
    }
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    println("User selected " + selection.getAbsolutePath());
    selected_file = selection.getAbsolutePath();
  }
}

String getDateTime() {
  int d = day();  
  int m = month(); 
  int y = year();  
  int h = hour();
  int min = minute();
  String s = String.valueOf(y);
  s = s + String.valueOf(m);
  s = s + String.valueOf(d);
  s = s + String.valueOf(h);
  s = s + String.valueOf(min);
  return s;
}
 int ArmPlayBack(float x, float y, float z, float g)
 {
   float M = sqrt((y*y)+(x*x));
  if (M <= 0)
    return 1;
  float a = -2*l2*(l1-z);
  float theta1 = atan2(y,x);
  float b = -2*l2*(x*cos(theta1)+y*sin(theta1));
  float c = l3*l3 - (z-l1)*(z-l1) - l2*l2 - pow((x*cos(theta1) + y*sin(theta1)),2);
  float theta2 = atan2(a,b) + atan2(sqrt(a*a + b*b - c*c),c);
  float d = (l1 - z)*sin(theta2) + (x*cos(theta1)+y*sin(theta1))*cos(theta2) - l2;
  float e = (l1 - z)*cos(theta2) - (x*cos(theta1)+y*sin(theta1))*sin(theta2);
  float theta3 = atan2(e,d);
  // Set value
  slider1.setValue(theta1);
  slider2.setValue(theta2);
  slider3.setValue(theta3);
  slider5.setValue(g); //Gripper
  //Base.write(theta1);
  //Shldr.write(theta2);
  //Elb.write(theta3);
  //Gripper.write(g);

  return 0; //That is important
  //  /*Elb.write(180 - Elbow);
  //   Shldr.write(Shoulder);
  //   Wrist.write(180 - Wris);
  //   Base.write(z);
  //   WristR.write(wr);
  //   Gripper.write(g);*/
  //  return 0;
 }

void saveCoordinates() {
  float x = slider2d1.getValueXI();
  float y = slider2d1.getValueYI();
  float z = slider1.getValueI();
  int g = slider5.getValueI();
  float w = slider6.getValueI();
  //output.println(x + "," + y + "," + z + "," + g + "," + w + "," + 90);
}
