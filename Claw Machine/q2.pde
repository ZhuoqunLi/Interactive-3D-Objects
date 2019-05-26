float eyeX = 0, eyeY = 0, eyeZ = 0, centerX = 0, centerY = 0, centerZ = -2, upX = 0, upY = 1, upZ = 0;
float tempAngleX=0;
float tempAngleY=0;
float armAngle=0;
boolean perspective = false;
float armSize=0.75;
float boxDistance=0.05;
float gripperAngle=30;
float gripperRotate=0;
int arraySize=(int)(3/0.3);
float[][][] randomArray=new float [arraySize][arraySize][4];
float craneMove=0;
int statusRotateArm=0;
int statusMoveCrane=0;
int statusUpDownClaw=0;
int gripperStatus=0;
int clawRotateStatus=0;
int clawAction=0;

void setup() {
  size(640, 640, P3D);

  randomGenerator();
  hint(DISABLE_OPTIMIZED_STROKE);
}
void draw() {
  actionGenerator();
  if (perspective)
    frustum(-1, 1, 1, -1, 1, 8);
  else
    ortho(-1, 1, 1, -1, 1, 8);
  
  clear();
  camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  drawBase();
  drawArm();
  drawFloor();
}
void drawFloor(){
    pushMatrix();
    colorMode(HSB);
    translate(0,0,-2.5);
    float CHEK = 0.3;
    int tempI=0;
  
    for (float i = -1; i < 1; i += CHEK) { 
      int tempJ=0;
      for (float j = -1;j < 1; j += CHEK) {
        pushMatrix();
        translate(i,-0.5,j);
        fill(randomArray[tempI][tempJ][1],randomArray[tempI][tempJ][2],randomArray[tempI][tempJ][3]);
        box(randomArray[tempI][tempJ][0]);
        popMatrix();
        tempJ++;
      }
      tempI++;
    }
    colorMode(RGB);
    popMatrix();
}

void randomGenerator(){
  for(int i=0;i<randomArray.length;i++){
    for(int j=0;j<randomArray[0].length;j++){
      randomArray[i][j][0]=random(0.05,0.15);
      randomArray[i][j][1]=random(0,256);
      randomArray[i][j][2]=random(0,128);
      randomArray[i][j][3]=255;
    }    
  }
}
void drawCable(){
  strokeWeight(5);
  stroke(128,128,128);
  beginShape(LINES);
  vertex(-1, 0,0);
  vertex(-1,-0.17-boxDistance,0);
  endShape();
  strokeWeight(1);
  stroke(0);
}
void drawJoin(){
  float xValue=(cos(radians(gripperAngle)))*(sqrt(2)/5);
  
  pushMatrix();
  translate(0+xValue,-0.2,0);
  scale(0.01);
  noStroke();
  sphere(5);  
  popMatrix();
  
  pushMatrix();
  translate(0-xValue,-0.2,0);
  scale(0.01);
  sphere(5);  
  popMatrix(); 
  
  stroke(1);
}
void drawGripper(){
  fill(255, 102, 26);
  drawLeftGripper();
  drawRightGripper();  
  fill(77, 77, 77);
  drawJoin();
}
void drawLeftGripper(){
  pushMatrix();
  float xValue=(cos(radians(gripperAngle)))*(sqrt(2)/5);
  strokeWeight(10);
  stroke(128,128,128);
  beginShape(LINES);
  vertex(0,0,0);
  vertex(0-xValue,-0.2,0);
  vertex(0-xValue,-0.2,0);
  vertex(0+(0.2-2*xValue),-0.4,0);
  endShape();
  strokeWeight(1);
  stroke(0);
  popMatrix(); 
}
void drawRightGripper(){
  pushMatrix();
  float xValue=(cos(radians(gripperAngle)))*(sqrt(2)/5);
  strokeWeight(10);
  stroke(128,128,128);
  beginShape(LINES);
  vertex(0,0,0);
  vertex(0+xValue,-0.2,0);
  vertex(0+xValue,-0.2,0);
  vertex(0-(0.2-2*xValue),-0.4,0);
  endShape();
  strokeWeight(1);
  stroke(0);  
  popMatrix(); 
}

void drawClawBox(){
  pushMatrix();  
  translate(-1,-0.17-boxDistance,0);
  rotateY(gripperRotate);
  fill(255, 92, 51);
  
  beginShape(QUADS);
  //+z front face,red
  vertex(-0.1, -0.1, 0.1);
  vertex( 0.1, -0.1, 0.1);
  vertex( 0.1, 0.1, 0.1);
  vertex(-0.1, 0.1, 0.1);
  
  //-z back face,white
  vertex(-0.1, -0.1, -0.1);
  vertex( 0.1, -0.1, -0.1);
  vertex( 0.1, 0.1, -0.1);
  vertex(-0.1, 0.1, -0.1);
  
  //-y top face,yellow
  vertex(-0.1, -0.1, 0.1);
  vertex( 0.1, -0.1, 0.1);
  vertex( 0.1, -0.1, -0.1);
  vertex(-0.1, -0.1, -0.1);
  
  //+y bottom face, blue
  vertex(-0.1, 0.1, 0.1);
  vertex( 0.1, 0.1, 0.1);
  vertex( 0.1, 0.1, -0.1);
  vertex(-0.1, 0.1, -0.1);
  
  //+x right face,purple
  vertex(0.1, 0.1, 0.1);
  vertex( 0.1, -0.1, 0.1);
  vertex( 0.1, -0.1, -0.1);
  vertex(0.1, 0.1, -0.1);
  
  //-x left face,grey
  vertex(-0.1, 0.1, 0.1);
  vertex( -0.1, -0.1, 0.1);
  vertex( -0.1, -0.1, -0.1);
  vertex(-0.1, 0.1, -0.1);
  endShape();

  drawGripper();
  popMatrix();  
    
}


void drawCrane(){
  pushMatrix();
  translate(0,-0.15,0);
  translate(craneMove,0,0);
  drawCable();
  
  fill(59, 179, 0);
  
  beginShape(QUADS);
  //+z front face,red
  vertex(-1.1, -0.1, 0.1);
  vertex( -0.9, -0.1, 0.1);
  vertex( -0.9, 0.1, 0.1);
  vertex(-1.1, 0.1, 0.1);
  
  //-z back face,white
  vertex(-1.1, -0.1, -0.1);
  vertex( -0.9, -0.1, -0.1);
  vertex( -0.9, 0.1, -0.1);
  vertex(-1.1, 0.1, -0.1);
  
  //-y top face,yellow
  vertex(-1.1, -0.1, 0.1);
  vertex( -0.9, -0.1, 0.1);
  vertex( -0.9, -0.1, -0.1);
  vertex(-1.1, -0.1, -0.1);
  
  //+y bottom face, blue
  vertex(-1.1, 0.1, 0.1);
  vertex( -0.9, 0.1, 0.1);
  vertex( -0.9, 0.1, -0.1);
  vertex(-1.1, 0.1, -0.1);
  
  //+x right face,purple
  vertex(-0.9, 0.1, 0.1);
  vertex( -0.9, -0.1, 0.1);
  vertex( -0.9, -0.1, -0.1);
  vertex(-0.9, 0.1, -0.1);
  
  //-x left face,grey
  vertex(-1.1, 0.1, 0.1);
  vertex( -1.1, -0.1, 0.1);
  vertex( -1.1, -0.1, -0.1);
  vertex(-1.1, 0.1, -0.1);
  endShape();
  
  drawClawBox();
  popMatrix();  
  
}
void drawArm(){
  pushMatrix();
  translate(0,0.6,-2.5);
  rotateY(armAngle);
  fill(255, 204, 0);
  
  beginShape(QUADS);
  //+z front face,red
  vertex(-1, -0.05, 0.05);
  vertex( 1, -0.05, 0.05);
  vertex( 1, 0.05, 0.05);
  vertex(-1, 0.05, 0.05);
  
  //-z back face,white
  vertex(-1, -0.05, -0.05);
  vertex( 1, -0.05, -0.05);
  vertex( 1, 0.05, -0.05);
  vertex(-1, 0.05, -0.05);
  
  //-y top face,yellow
  vertex(-1, -0.05, 0.05);
  vertex( 1, -0.05, 0.05);
  vertex( 1, -0.05, -0.05);
  vertex(-1, -0.05, -0.05);
  
  //+y bottom face, blue
  vertex(-1, 0.05, 0.05);
  vertex( 1, 0.05, 0.05);
  vertex( 1, 0.05, -0.05);
  vertex(-1, 0.05, -0.05);
  
  //+x right face,purple
  vertex(1, 0.05, 0.05);
  vertex( 1, -0.05, 0.05);
  vertex( 1, -0.05, -0.05);
  vertex(1, 0.05, -0.05);
  
  //-x left face,grey
  vertex(-1, 0.05, 0.05);
  vertex( -1, -0.05, 0.05);
  vertex( -1, -0.05, -0.05);
  vertex(-1, 0.05, -0.05);
  endShape();
  drawCrane();
  popMatrix();
}
void drawBase(){
  pushMatrix();
  translate(0,0.75,-2.5);
  scale(0.2, 0.2, 0.2);  
  fill(77, 38, 0);
  
  beginShape(QUADS);
  //+z front face,red
  vertex(-1, -0.5, 0.4);
  vertex( 1, -0.5, 0.4);
  vertex( 1, 0.5, 0.4);
  vertex(-1, 0.5, 0.4);
  
  //-z back face,white
  vertex(-1, -0.5, -0.4);
  vertex( 1, -0.5, -0.4);
  vertex( 1, 0.5, -0.4);
  vertex(-1, 0.5, -0.4);
  
  //-y top face,yellow
  vertex(-1, -0.5, 0.4);
  vertex( 1, -0.5, 0.4);
  vertex( 1, -0.5, -0.4);
  vertex(-1, -0.5, -0.4);
  
  //+y bottom face, blue
  vertex(-1, 0.5, 0.4);
  vertex( 1, 0.5, 0.4);
  vertex( 1, 0.5, -0.4);
  vertex(-1, 0.5, -0.4);
  
  //+x right face,purple
  vertex(1, 0.5, 0.4);
  vertex( 1, -0.5, 0.4);
  vertex( 1, -0.5, -0.4);
  vertex(1, 0.5, -0.4);
  
  //-x left face,grey
  vertex(-1, 0.5, 0.4);
  vertex( -1, -0.5, 0.4);
  vertex( -1, -0.5, -0.4);
  vertex(-1, 0.5, -0.4);
  endShape();
  popMatrix();
}

void actionGenerator(){
  if(clawAction==0){
    if(statusRotateArm==1){//rotate arm to one side
      armAngle=armAngle+0.02;
    }
    else if(statusRotateArm==2){//rotate arm to the other side
      armAngle=armAngle-0.02;
    }
    
    if(statusMoveCrane==1){//crane move to left side
      if(craneMove>0){
        craneMove=craneMove-0.01;
      }    
    }
    else if(statusMoveCrane==2){//crane move to right side
      if(craneMove<2){
        craneMove=craneMove+0.01;
      }    
    }
    
    if(statusUpDownClaw==1){//box move down
      if(boxDistance<0.46){
        boxDistance=boxDistance+0.003;
      }    
    }
    else if(statusUpDownClaw==2){//box move up
      if(boxDistance>0.05){
        boxDistance=boxDistance-0.003;
      }    
    }
    
    if(gripperStatus==1){//gripper close
      if(gripperAngle<65){
        gripperAngle=gripperAngle+1;
      }    
    }
    else if(gripperStatus==2){//gripper open
      if(gripperAngle>30){
        gripperAngle=gripperAngle-1;
      }    
    }
    
    if(clawRotateStatus==1){//claw rotate one direction
      gripperRotate=gripperRotate+0.02;    
    }
    else if(clawRotateStatus==2){//claw rotate to another direction
      gripperRotate=gripperRotate-0.02;    
    }
  }
  else{
      if((gripperAngle>30) && (gripperStatus==2)){//open gripper
        gripperAngle=gripperAngle-1;
        if(gripperAngle>=65){
          gripperStatus=0;
          statusUpDownClaw=1;
        }
      }
      else if((gripperStatus==2)&&(!(gripperAngle>30))){
        gripperStatus=0;
        statusUpDownClaw=1;
      }
      
      if((boxDistance<0.46)&&(statusUpDownClaw==1)){//crane box moving down
        boxDistance=boxDistance+0.003;
        if(!(boxDistance<0.46)){
          statusUpDownClaw=0;
          gripperStatus=1;
        }
      }
      else if((!(boxDistance<0.46))&&(statusUpDownClaw==1)){
        statusUpDownClaw=0;
        gripperStatus=1;        
      }
      
      if((gripperAngle<65) && (gripperStatus==1)){//open gripper
        gripperAngle=gripperAngle+1;
        if(!(gripperAngle<65)){
          gripperStatus=0;
          statusUpDownClaw=2;
        }
      }
      else if(((!(gripperAngle<65)) && (gripperStatus==1))){
        gripperStatus=0;
        statusUpDownClaw=2;
      }
      
      if((boxDistance>0.05)&&(statusUpDownClaw==2)){//crane box moving down
        boxDistance=boxDistance-0.003;
        if(!(boxDistance>0.05)){
          statusUpDownClaw=0;
          clawAction=0;
          statusRotateArm=0;
          statusMoveCrane=0;
          statusUpDownClaw=0;
          gripperStatus=0;
          clawRotateStatus=0;
          clawAction=0;
        }
      }
      else if(((!(boxDistance>0.05))&&(statusUpDownClaw==2))){
        statusUpDownClaw=0;
        clawAction=0;
        statusRotateArm=0;
        statusMoveCrane=0;
        statusUpDownClaw=0;
        gripperStatus=0;
        clawRotateStatus=0;
        clawAction=0;
      }
  }
}
void keyPressed() {
  switch (key) {
  case 'q':
    if(clawAction==1){}
    else if(statusRotateArm==1){
      statusRotateArm=0;
    }
    else{
      statusRotateArm=1;
    }
    break;
  case 'w':
    if(clawAction==1){}
    else if(statusRotateArm==2){
      statusRotateArm=0;
    }
    else{
      statusRotateArm=2;
    }
    break;
  case 'p':
    if(!perspective){
      perspective = !perspective;
    }
    break;
  case 'o':
    if(perspective){
      perspective = !perspective;
    }
    break;
  case 'r':
    if(clawAction==1){}
    else if(statusMoveCrane==2){
      statusMoveCrane=0;
    }
    else{
      statusMoveCrane=2;
    }
    break;
  case 'e':
    if(clawAction==1){}
    else if(statusMoveCrane==1){
      statusMoveCrane=0;
    }
    else{
      statusMoveCrane=1;
    }
    break;
  case 'z':
    if(clawAction==1){}
    else if(statusUpDownClaw==1){
      statusUpDownClaw=0;
    }
    else{
      statusUpDownClaw=1;
    }
    break;
  case 'a':
    if(clawAction==1){}
    else if(statusUpDownClaw==2){
      statusUpDownClaw=0;
    }
    else{
      statusUpDownClaw=2;
    }
    break;
  case 'c':
    if(clawAction==1){}
    else if(gripperStatus==1){
      gripperStatus=0;
    }
    else{
      gripperStatus=1;
    }
    break;
  case 'x':
    if(clawAction==1){}
    else if(gripperStatus==2){
      gripperStatus=0;
    }
    else{
      gripperStatus=2;
    }
    break;
  case 's':
    if(clawAction==1){}
    else if(clawRotateStatus==1){
      clawRotateStatus=0;
    }
    else{
      clawRotateStatus=1;
    }
    break;
  case 'd':
    if(clawAction==1){}
    else if(clawRotateStatus==2){
      clawRotateStatus=0;
    }
    else{
      clawRotateStatus=2;
    }
    break;
  case ' ':
    if(clawAction!=1){
      clawAction=1;
      gripperStatus=2;
    }
    else{}
    break;
  case '1':
    eyeX = 0;
    eyeY = 0;
    eyeZ = 0.2;
    centerX = 0;
    centerY = 0;
    centerZ = -2;
    upX = 0;
    upY = 1;
    upZ = 0;
    break;
  case '2':
    eyeX = 0.7;
    eyeY = 1.3;
    eyeZ = -0.3;
    centerX = 0;
    centerY = 0;
    centerZ = -2.6;
    upX = 0.7;
    upY = 6.8;
    upZ = 1;
    break;
  case '3':
    eyeX = -1.7;
    eyeY = 3.1;
    eyeZ = -2.9;
    centerX = -0.6;
    centerY = 0.6;
    centerZ = -2.7;
    upX = 3.7;
    upY = 0.6;
    upZ = 0;
    break;
  }
}
