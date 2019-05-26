float[] position = { 0.0, 0.0, 0.0 };
float facing = 0;
float nextFacing=0;
float oldFacing=0;
PImage bg1,bg2,bg3,bg4,floor,box1,box2,box3,box4;
PImage sphere1,sphere2,sphere3,sphere4;
float bgX=16,bgY=8,bgZ=16;
PShape glassBox,hemispheroid1,hemispheroid2,hemispheroid3,hemispheroid4;
float boxSize=2;
float rotateVar=0;
int moveViewCount=0;
int wsCount=0;
boolean wAction=false;
boolean sAction=false;
float varAction1=0;
float varAction2=0;
float oldp0,oldp2;
boolean dLight=false;
boolean bLight=false;
boolean sLight=false;
boolean firstPerson=true;
  
  
void setup(){
  size(800,600,P3D);
  frustum(-float(width)/height, float(width)/height, 1, -1, 2, 36);
  resetMatrix();
  
  bg1=loadImage("ocean2.jpg");
  bg2=loadImage("ocean2.jpg");
  bg3=loadImage("ocean2.jpg");
  bg4=loadImage("ocean2.jpg");
  floor=loadImage("floor.jpg");
  box1=loadImage("stone1.jpg");
  box2=loadImage("stone2.jpg");
  box3=loadImage("stone3.jpg");
  box4=loadImage("stone4.jpg");
  sphere1=loadImage("sphere1.jpg");
  sphere2=loadImage("sphere2.jpg");
  sphere3=loadImage("sphere3.jpg");
  sphere4=loadImage("sphere4.jpg");
  glassBox=createShape(BOX,boxSize/2,boxSize,boxSize/2);
  noStroke();
  hemispheroid1=createShape(SPHERE,boxSize/4);
  hemispheroid2=createShape(SPHERE,boxSize/4);
  hemispheroid3=createShape(SPHERE,boxSize/4);
  hemispheroid4=createShape(SPHERE,boxSize/4);
}

void draw(){
  if(dLight){
    directionalLight(255, 255, 175, -9, 5,-9);
    directionalLight(255, 255, 175, 9, 5,-9);
  }
  if(bLight){
    ambientLight(255, 185, 9, -9, 5,-9);
  }

  background(0, 0, 0.1);
  moveView();
  rotateView();
  translate(0, 6, -4);
  rotateY(-facing * PI/2);
  translate(-position[0], 0, -position[2]);
  
  if(sLight){
    spotLight(255, 255, 255, 0, 0, 0, 0, -4, 0, PI/12,600);
  }
  
  drawWall();
  drawFloor();
  drawExhibits();
  
}

void moveView(){
  if(wAction){
    if((facing==0)||(facing==1)){
      if(varAction1!=0){
        position[0]=position[0]-0.05;
      }
      if(varAction2!=0){
        position[2]=position[2]-0.05;
      }
    }
    else{
      if(varAction1!=0){
        position[0]=position[0]+0.05;
      }
      if(varAction2!=0){
        position[2]=position[2]+0.05;
      }
    }
  }
  else if(sAction){
    if((facing==0)||(facing==1)){
      if(varAction1!=0){
        position[0]=position[0]+0.05;
      }
      if(varAction2!=0){
        position[2]=position[2]+0.05;
      }    
    }
    else{
      if(varAction1!=0){
        position[0]=position[0]-0.05;
      }
      if(varAction2!=0){
        position[2]=position[2]-0.05;
      }       
    }
  }
  wsCount++;
  if(wsCount==19){
    if(wAction){
      if((facing==0)||(facing==1)){
        if(varAction1!=0){
          position[0]=oldp0-1;;
        }
        if(varAction2!=0){
          position[2]=oldp2-1;
        }
      }
      else{
        if(varAction1!=0){
          position[0]=oldp0+1;;
        }
        if(varAction2!=0){
          position[2]=oldp2+1;
        }
      }
    }
    else if(sAction){
      if((facing==0)||(facing==1)){
        if(varAction1!=0){
          position[0]=oldp0+1;
        }
        if(varAction2!=0){
          position[2]=oldp2+1;
        }  
      }
      else{
        if(varAction1!=0){
          position[0]=oldp0-1;
        }
        if(varAction2!=0){
          position[2]=oldp2-1;
        }  
      }
    }
    wAction=false;
    sAction=false;
  }  
}
void rotateView(){
  if(facing!=nextFacing){
    if( ((oldFacing==0) &&(nextFacing==1))|| ((oldFacing==1) &&(nextFacing==2)) ||((oldFacing==2) &&(nextFacing==3)) ||((oldFacing==3) &&(nextFacing==0))     ){
      facing=facing+0.05;
    }
    else{
      facing=facing-0.05;
    }
  }
  moveViewCount++;
  if(moveViewCount==19){
    facing=nextFacing;
    oldFacing=facing;
  }
}
void drawExhibits(){
  textureMode(IMAGE);
  rotateVar=rotateVar%360;
  
  pushMatrix();  
  glassBox.setTexture(box1);
  translate(bgX/2, -(bgY-(boxSize/2)), bgZ/2);
  shape(glassBox);
  
  hemispheroid1.setTexture(sphere1);
  translate(0, -(-(boxSize/2)-(boxSize/4)), 0);
  rotateY(rotateVar);
  shape(hemispheroid1);
  popMatrix();
  
  pushMatrix();
  glassBox.setTexture(box2);
  translate(-(bgX/2), -(bgY-(boxSize/2)), bgZ/2);
  shape(glassBox);
  translate(0, -(-(boxSize/2)-(boxSize/4)), 0);
  hemispheroid2.setTexture(sphere2);
  rotateY(rotateVar);
  shape(hemispheroid2);
  popMatrix();
  
  pushMatrix();
  glassBox.setTexture(box3);
  translate(bgX/2, -(bgY-(boxSize/2)), -(bgZ/2));
  shape(glassBox);
  hemispheroid3.setTexture(sphere3);
  translate(0, -(-(boxSize/2)-(boxSize/4)), 0);
  rotateY(rotateVar);
  shape(hemispheroid3);
  popMatrix();
  
  pushMatrix();
  glassBox.setTexture(box4);
  translate(-(bgX/2), -(bgY-(boxSize/2)), -(bgZ/2));
  shape(glassBox);
  hemispheroid4.setTexture(sphere4);
  translate(0, -(-(boxSize/2)-(boxSize/4)), 0);
  rotateY(rotateVar);
  shape(hemispheroid4);
  popMatrix();
  
  
  rotateVar=rotateVar+0.05;
}


void drawFloor(){
  textureMode(NORMAL);
  textureWrap(REPEAT);
  int mult=9;
  float paraX=bgX;
  float paraY=bgY;
  float paraZ=bgZ;
  beginShape(QUADS);
  texture(floor);
  vertex(-paraX,-paraY,paraZ, 0,mult);
  vertex(paraX,-paraY,paraZ,  mult,mult);
  vertex(paraX,-paraY,-paraZ,   mult,0);
  vertex(-paraX,-paraY,-paraZ,  0,0);
  endShape(); 
}

void drawWall(){
  textureMode(IMAGE);
  float paraX=bgX;
  float paraY=bgY;
  float paraZ=bgZ;
  int pictureheight=1792;
  int pictureWidth=2688;

  beginShape(QUADS);
  texture(bg1);
  vertex(-paraX, paraY,paraZ,0,0);
  vertex(paraX, paraY, paraZ,pictureWidth,0);
  vertex(paraX, -paraY, paraZ,pictureWidth,pictureheight);
  vertex(-paraX, -paraY,paraZ, 0,pictureheight);
  endShape();
  
  beginShape(QUADS);
  texture(bg2);
  vertex(-paraX, paraY, paraZ,0,0);
  vertex(-paraX, paraY, -paraZ,pictureWidth,0);
  vertex(-paraX, -paraY, -paraZ,pictureWidth,pictureheight);
  vertex(-paraX, -paraY, paraZ,0,pictureheight);
  endShape();
  
  beginShape(QUADS);
  texture(bg3);
  vertex(-paraX, paraY, -paraZ,0,0);
  vertex(paraX, paraY, -paraZ,pictureWidth,0);
  vertex(paraX, -paraY, -paraZ,pictureWidth,pictureheight);
  vertex(-paraX, -paraY, -paraZ,0,pictureheight);
  endShape();
  
  beginShape(QUADS);
  texture(bg4);
  vertex(paraX, paraY, paraZ,0,0);
  vertex(paraX, paraY, -paraZ,pictureWidth,0);
  vertex(paraX, -paraY, -paraZ,pictureWidth,pictureheight);
  vertex(paraX, -paraY, paraZ,0,pictureheight);
  endShape();
}
void keyPressed() {
  switch (key) {
  case 'w':
    if((!wAction)&&(!sAction)){
      if( (-14<((position[0]+((facing % 2) * (facing % 4 == 1 ? -1 : 1)))))&& ((position[0]+((facing % 2) * (facing % 4 == 1 ? -1 : 1)))<14)  && ((position[2]+((facing + 1) % 2) * (facing % 4 == 0 ? -1 : 1))>-14) &&((position[2]+((facing + 1) % 2) * (facing % 4 == 0 ? -1 : 1))<14) && (boundCheck(position[0],position[2],((facing % 2) * (facing % 4 == 1 ? -1 : 1)),(((facing + 1) % 2) * (facing % 4 == 0 ? -1 : 1)),'w'))){
        wAction=true;
        varAction1=(facing % 2) * (facing % 4 == 1 ? -1 : 1);
        varAction2=((facing + 1) % 2) * (facing % 4 == 0 ? -1 : 1);
        wsCount=0;
        oldp0=position[0];
        oldp2=position[2];
      }
    }
    break;
  case 'a':
    if((facing==nextFacing)){
      oldFacing=facing;
      nextFacing= (facing + 1) % 4;
      moveViewCount=0;
    }
    break;
  case 's':
    if((!sAction)&&(!wAction)){
      if( (-14<((position[0]-((facing % 2) * (facing % 4 == 1 ? -1 : 1)))))&& ((position[0]-((facing % 2) * (facing % 4 == 1 ? -1 : 1)))<14)  && ((position[2]-((facing + 1) % 2) * (facing % 4 == 0 ? -1 : 1))>-14) &&((position[2]-((facing + 1) % 2) * (facing % 4 == 0 ? -1 : 1))<14) ){//&& (boundCheck(position[0],position[2],((facing % 2) * (facing % 4 == 1 ? -1 : 1)),(((facing + 1) % 2) * (facing % 4 == 0 ? -1 : 1)),'s'))){
        sAction=true;
        varAction1=(facing % 2) * (facing % 4 == 1 ? -1 : 1);
        varAction2=((facing + 1) % 2) * (facing % 4 == 0 ? -1 : 1);
        wsCount=0;
        oldp0=position[0];
        oldp2=position[2];
      }
    }
    break;
  case 'd':
    if(facing==nextFacing){
      oldFacing=facing;
      nextFacing= (facing + 3) % 4;
      moveViewCount=0;
    }
    break;

  case '1':
    dLight=!dLight;  
    break;
    
  case '2':
    bLight=!bLight;
    break;
    
  case '3':
    sLight=!sLight;
    break;
  }
}
boolean boundCheck(float p1,float p2, float vp1,float vp2,char status){
  boolean result=true;
  float newP1=0,newP2=0;
  if(status=='s'){
    newP1=p1+vp1;//x
    newP2=p2+vp2;//z
  }
  else if(status=='w'){
    newP1=p1-vp1;//x
    newP2=p2-vp2;//z
  }
  if(   ((newP1<-6)&&(newP1>-10)&&(newP2<-6)&&(newP2>-10)) || ((newP1<10)&&(newP1>6)&&(newP2<-6)&&(newP2>-10))  || ((newP1<10)&&(newP1>6)&&(newP2<10)&&(newP2>6)) || ((newP1<-6)&&(newP1>-10)&&(newP2<10)&&(newP2>6))){
    result=false;
  }
  
  
  
  return result;
}
