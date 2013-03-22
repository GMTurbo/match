import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class match extends PApplet {



//import damkjer.ocd.*;

ArrayList<group> groups = new ArrayList<group>();

Minim minim;
AudioPlayer player;
AudioPlayer match;
AudioPlayer error;
//AudioInput input;
//Camera camera1;
int startingTime = 0;
int endTime = 0;
public void setup(){
  
  size(600, 850, P3D);
  minim = new Minim(this);
  player = minim.loadFile("closed.mp3");
  //player.setVolume(0.5);
  player.setGain(-18.0f);
  println(player.getControls());
  match = minim.loadFile("matched.mp3");
  match.setGain(-6.0f);
  //error = minim.loadFile("error.mp3");
  player.loop();
  player.play();
  //input = minim.getLineIn();
  smooth(8);
  //
  //camera1.aim(width/2, height/2, 0);
  PFont font= createFont("Helvetica Neue", 256, true);
  textFont(font);
  initialize();
}

public void stop()
{
  player.close();
  match.close();
  error.close();
  
  minim.stop();
  super.stop();
}

int uidStep = 0;

public boolean alreadyHasTwo(int number, int[][] checkArray, int rows, int cols){
  int checkCount = 0;
  
  for(int i = 0 ; i < rows; i++){
    
     for( int j = 0 ; j < cols; j++){
       
       if(checkArray[i][j] == number){
         checkCount++;
       }
         //println("
     }
   }
   
   println("checkCount = "+ checkCount);// == 2;
   return checkCount == 2;
}
public void initialize(){
  //int offsetX = 
  firstMouseDown = false;
    groups.clear();
    int boardX = 5;
    int boardY = 6;
  
   int[][] typeArray = new int[boardX][boardY];
   for(int i = 0 ; i < boardX; i++){
     for( int j = 0 ; j < boardY; j++){
       typeArray[i][j] = -1;
     }
   }
   int randomType = -1;
   for(int i = 0 ; i < boardX; i++){
     for( int j = 0 ; j < boardY; j++){
       
       randomType = ceil(random(0,typeSize));
       while(alreadyHasTwo(randomType, typeArray, boardX, boardY)){
         randomType = ceil(random(0,typeSize));
       }
       println("typeArray["+i+"]["+j+"]="+randomType);
       typeArray[i][j] = randomType;
       
     }
   }
   
   int stepX = ceil(PApplet.parseFloat(width)/PApplet.parseFloat(boardX));
   int stepY = ceil(PApplet.parseFloat(height)/PApplet.parseFloat(boardY));
   
   for(int i = 0 ; i < boardX; i ++){
     for( int j = 0 ; j < boardY; j++){
       
       uidStep += PApplet.parseInt(random(uidStep, uidStep+5));
       
       group g = new group(60 + i*stepX, 50+j*stepY, uidStep, typeArray[i][j]);
       
       groups.add(g);
       println(groups.size());
       
     }
   }
   
   
}

public boolean canAdd(group check){
    
    int foundCount = 0;
    
    for(int i = 0 ; i < groups.size() ; i++) //check all group types
    {
      if(groups.get(i).id == check.id){
        foundCount++;
      }  
    }
    if(foundCount == 2)
      return false;
    return true;
     
}
boolean firstMouseDown = false;
public void draw(){
  
   
   background(255); 
   lights();
   //camera1.feed();
   
  // draw time
   if(firstMouseDown){
     int seconds = ((ended ? endTime : millis()) - startingTime) / 1000;
     int minutes = seconds / 60;
     int hours = minutes / 60;
     seconds -= minutes * 60;
     minutes -= hours * 60;
     fill(0);
     stroke(0);
     float t = (endTimer > 1.0f) ? 1.0f : endTimer;
     
     fill(20, 20, 20, ended ? 50 + t*205 : 50);
     textAlign(LEFT);
     //strokeWeight(2);
     if(ended) {
       textSize(80);
       text("Finished",width/2 - 140,height/2 - 155, -50 + t*150);
       textSize(256);
     }
       
     text(( minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds),width/2 - 240,height/2 + 40, -50 + t*150);
     }
   
   stroke(0);
   strokeWeight(2);
   
   rect(mouseX + 5/2, mouseY + 5/2, 5, 5);
   
   for(group g : groups){
      g.draw(); 
   }
   
   if(endTimer > 2.8f && ended){
      println("end sequence is done");
      endTimer = 0;
      ended = false;
      initialize(); 
   }else if(ended){ endTimer += 0.01f; }
     
}

float endTimer = 0;
boolean ended = false;

public void keyPressed(){
   switch(key){
      case 'c': //center
      initialize();
      break;
      case 's':
      saveFrame("screenCap" + (screenCap++) + ".png");
      println("saved screenshot: " + screenCap);
      break;
   } 
   
}

int screenCap = 0;

public void mouseClicked(){
   for(group g: groups) 
     g.deSelectAll(); 
}

boolean somethingSelected = false;

group current = null;
group selectedGroup1 = null;
group selectedGroup2 = null;
int selectedCount = 1;
public void mousePressed(){
  
  if(firstMouseDown == false){
     firstMouseDown = true;
     startingTime = millis();
    }
    
  current = null;
  for(group g: groups) { 
    g.selected = false;
    g.SetSelected(mouseX, mouseY);
    if(g.selected){
      
      selectedCount++;
      current = g;
      
      if(selectedGroup1 == null)
        selectedGroup1 = g;
      
      else if(selectedGroup1 != null && selectedGroup2 == null)
        selectedGroup2 = g;
        
      break;
    }
    
  }
  
  if(selectedGroup1!=null && selectedGroup2!=null){
     compareGroups(selectedGroup1, selectedGroup2); 
     selectedGroup1.selected = false;
     selectedGroup2.selected = false;
     current.selected = false;
     current = null;
     selectedGroup1=null;
     selectedGroup2=null;
     
     boolean done = true;
     for(group g: groups){
        done &= g.hide; 
     }
     
     if(done){
       endTime = millis();
       println("game ended");
       ended = true;
     }
     
  }
}

public void compareGroups(group g1, group g2){
   // if they are the same things then make them disappear and maybe do some text stuff
  if(g1.id == g2.id && g1 != g2){
    //match.position(0);
    match.rewind();
     match.play();
     g1.hide();
     g2.hide();
     //showScore();
  } else{
    // error.rewind();
    // error.play(); 
  }
}

public void mouseReleased(){
  //somethingSelected = false;
  //selectedGroup1 = null;
    //for(group g: groups) { 
    //g.selected = false;
  //}
}

public void mouseDragged() {
  
  if(current != null){
    println(current + " is selected");
    
    float xx = mouseX -  current.x;
    float yy = mouseY - current.y;
    fill(0);
    rect(current.x, current.y, 10 ,10);
    float yaw = atan2(yy, xx);
    float pitch = atan2(current.x,  sqrt((xx * xx) + (yy * yy)) * (mouseX > current.x ? 1 : -1));
    current.setAngle(yaw, pitch);
    println("yaw: " + yaw + " | pitch: " + pitch);
    //selectedGroup.setAngle(atan2( mouseX - (selectedGroup.x + width/7), mouseY - (selectedGroup.y + width/7)));
  }
  
  if(current == null){
   if(mouseButton == LEFT){
      //camera1.track(pmouseX - mouseX, pmouseY - mouseY);
    }
    else if(mouseButton == RIGHT){
      //camera1.look(radians(mouseX - pmouseX) / 2.0, radians(mouseY - pmouseY) / 2.0); 
    }
  }
}

public void mouseMoved(){
  if(keyPressed && keyCode == CONTROL){
      //println("zooming");
     // camera1.zoom(radians(mouseY - pmouseY) / 2.0);
    }
}

class block{
  
   int c;
   int cc;
   int x;
   int y;
   int z;
   //float yaw= 0;
   //float pitch = 0;
   boolean selected = false;
   int size = 10;
   
   int rotateX = 0; int rotateY = 0; int rotateZ = 0;
   
   boolean useColor = true;

   block(int xpos, int ypos, int zpos, int s, float ang, int rotateAboutX, int rotateAboutY, int rotateAboutZ){
    x = xpos;
    y = ypos;
    z = zpos;
    rotateX = rotateAboutX;
    rotateY = rotateAboutY;
    rotateZ = rotateAboutZ;
    size = s;
    //yaw = ang; 
    int v = PApplet.parseInt(random(90, 255));
    
    c = color(v, v, v);
    cc = color(PApplet.parseInt(random(10, 240)),PApplet.parseInt(random(10, 240)),PApplet.parseInt(random(10, 240)));
      
   }
   
   public void setSelected(boolean state){
     selected = state;
   } 
   boolean hide = false;
   public void hide(){
       hide = true;
       selected = false;
   }
   float clock = -TWO_PI;
   public void draw(float yaw, float pitch, float timer){
     
     //yaw = y;
     //pitch = p;
     if( hide ){
         PVector start = new PVector(x, y, z);
         PVector end = new PVector(x, y, z + 100);
         PVector middle = PVector.lerp(start, end, timer );
         
         pushMatrix();
       
         translate(middle.x, middle.y, middle.z);
       
         rotateX(pitch + timer * PI/10);
         rotateZ(yaw + timer * PI/10);
         rotateZ(clock + timer * PI/10);
       
         translate(rotateX, rotateY, rotateZ);
         fill(97,255,47, 255-timer*255);
         stroke(97,255,47);
         
         if(timer==1.0f){
           noFill();
           noStroke();
         }
       
         strokeWeight(1);
       
         box(size);
       
         popMatrix();
         
     }else{
       pushMatrix();
       
       translate(x, y, z);
       
       //rotateX(yaw);
       rotateX(pitch);
       rotateZ(yaw);
       rotateZ(clock);
       
       translate(rotateX, rotateY, rotateZ);
       fill(selected ? color(cc, 90) : cc);
       if(selected)
         stroke(color(125,223,252));
       else
        stroke(0);
       strokeWeight(selected ? 1.0f : 0.5f);
       
       box(size);
       
       popMatrix();
     }
     
     clock += PI/800;
     clock = clock%TWO_PI;
      
   } 
}


int typeSize = 15;

class group{
  
  ArrayList<block> blocks = new ArrayList<block>();
  
  int x;
  int y;
  boolean selected = false;
  int GUI = -1;
  float yaw = 0;
  float pitch = 0;
  int id = -1;
  
  boolean opposite = false;
   
  group(int xpos, int ypos, int guid, int tp){
    x = xpos;
    y = ypos;
    GUI = guid;
    opposite = PApplet.parseBoolean(round(random(0,1)));
    yaw = random(0, PI);
    buildBlock(tp);
  }
  
  public void deSelectAll() { 
    for(block b: blocks) { b.selected = false;}
  }
  
  public void buildBlock(int type){
    //println("building group here: (" + x + ", " + y + ")" );
    //block(int xpos, int ypos, int zpos, int size, float ang, int rotateAboutX, int rotateAboutY)
    id = type;
    int size = 12;
    switch(type){
     case 1:
       blocks.add(new block( x, y, 0, size, yaw, 0 * size, 0, 0));
       blocks.add(new block( x, y, 0, size, yaw, 1 * size, 0, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 2 * size, 0, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 1 * size, 1* size, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 2 * size, 1* size, 0 ));
     
     break;
     
     case 2:
     
       blocks.add(new block( x, y, 0, size, yaw, 0, -1* size, 1* size ));
       blocks.add(new block( x, y, 0, size, yaw, 0, -1* size, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 0));
       blocks.add(new block( x, y, 0, size, yaw, 1* size, -1* size, 0));
       blocks.add(new block( x, y, 0, size, yaw, 2* size, -1* size, 0));
       blocks.add(new block( x, y, 0, size, yaw, 2* size, -1* size, -1* size));
       
     break;
     
     case 3:
     
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 1* size, 0, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, -1* size, 0, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 1* size, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 0, -1* size, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, -1* size ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 1* size ));
       

       
     break;
     
     case 4:
     
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 1* size, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 2* size, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 3* size, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 4* size, 0 ));
       
       blocks.add(new block( x, y, 0, size, yaw, 0, 2* size, 10 ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 1* size ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 2* size, 2* size ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 2* size ));
       
       blocks.add(new block( x, y, 0, size, yaw, 0, 1* size, 2* size ));
       
     break;
     
     case 5:
     
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 0 ));
       
       blocks.add(new block( x, y, 0, size, yaw, 1* size, 0, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 2* size, 0, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 3* size, 0, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 4* size, 0, 0 ));
       
       blocks.add(new block( x, y, 0, size, yaw, 0, 1* size, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 2* size, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 3* size, 0 ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 4* size, 0 ));
       
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 1* size ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 2* size ));
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 3* size));
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 4* size));
       
     break;
     
     case 6:
       // OOO
       // O O
       // OOO
       
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 0 ));   
       blocks.add(new block( x, y, 0, size, yaw, 1* size, 0, 0));
       blocks.add(new block( x, y, 0, size, yaw, 2* size, 0, 0));
       
       blocks.add(new block( x, y, 0, size, yaw, 0, 1* size, 0));
       blocks.add(new block( x, y, 0, size, yaw, 2* size, 1* size, 0));
       
       blocks.add(new block( x, y, 0, size, yaw, 0, 2* size, 0));
       blocks.add(new block( x, y, 0, size, yaw, 1* size, 2* size, 0));
       blocks.add(new block( x, y, 0, size, yaw, 2* size, 2* size, 0));
       
       
     break;
     
     case 7:
       // OOO  0,20 10,20 20,20z
       // O O  0 0z
       // OOO  
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 0 ));   
       blocks.add(new block( x, y, 0, size, yaw, 1* size, 0, 0));
       blocks.add(new block( x, y, 0, size, yaw, 2* size, 0, 0));
       
       blocks.add(new block( x, y, 0, size, yaw, 0, 1* size, 0));
       blocks.add(new block( x, y, 0, size, yaw, 2* size, 1* size, 0));
       
       blocks.add(new block( x, y, 0, size, yaw, 0, 2* size, 0));
       blocks.add(new block( x, y, 0, size, yaw, 1* size, 2* size, 0));
       blocks.add(new block( x, y, 0, size, yaw, 2* size, 2* size, 0));
       
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 1* size));
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 2* size));
       
       blocks.add(new block( x, y, 0, size, yaw, 0, 2* size, 1* size));
       blocks.add(new block( x, y, 0, size, yaw, 0, 2* size, 2* size));
       
       blocks.add(new block( x, y, 0, size, yaw, 2* size, 0, 1* size));
       blocks.add(new block( x, y, 0, size, yaw, 2* size, 0, 2* size));
       
       blocks.add(new block( x, y, 0, size, yaw, 2* size, 2* size, 1* size));
       blocks.add(new block( x, y, 0, size, yaw, 2* size, 2* size, 2* size));
       
     break;
     
     case 8:
       
       blocks.add( new block( x, y, 0, size, yaw, -2*size, 2*size, 0*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, -2*size, 1*size, 0*size ) ); 
     
       blocks.add( new block( x, y, 0, size, yaw, -1*size, 3*size, 0*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, -1*size, 2*size, 0*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, -1*size, 1*size, 0*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, -1*size, 0*size, 0*size ) ); 
       
       blocks.add( new block( x, y, 0, size, yaw, 0*size, 2*size, 0*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 0*size, 0*size,  0*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 0*size, -1*size,  0*size ) ); 
       
       blocks.add( new block( x, y, 0, size, yaw, 2*size, 2*size, 0*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 2*size, 1*size, 0*size ) ); 
     
       blocks.add( new block( x, y, 0, size, yaw, 1*size, 3*size, 0*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 1*size, 2*size, 0*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 1*size, 1*size, 0*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 1*size, 0*size, 0*size ) ); 
       
     break;
     
     case 9:
       
       blocks.add( new block( x, y, 0, size, yaw, 0*size, 0*size,  0*size ) );
       
       blocks.add( new block( x, y, 0, size, yaw, -1*size, 1*size,  1*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, -1*size, -1*size,  1*size ) );
       
       blocks.add( new block( x, y, 0, size, yaw, -1*size, 1*size,  -1*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, -1*size, -1*size,  -1*size ) ); 
       
       blocks.add( new block( x, y, 0, size, yaw, 1*size, 1*size,  1*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 1*size, -1*size,  1*size ) ); 
       
       blocks.add( new block( x, y, 0, size, yaw, 1*size, 1*size,  -1*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 1*size, -1*size, -1*size ) ); 
       
       blocks.add( new block( x, y, 0, size, yaw, -2*size, 2*size,  2*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, -2*size, -2*size,  2*size ) );
       
       blocks.add( new block( x, y, 0, size, yaw, -2*size, 2*size,  -2*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, -2*size, -2*size,  -2*size ) ); 
       
       blocks.add( new block( x, y, 0, size, yaw, 2*size, 2*size,  2*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 2*size, -2*size,  2*size ) ); 
       
       blocks.add( new block( x, y, 0, size, yaw, 2*size, 2*size,  -2*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 2*size, -2*size, -2*size ) ); 
       
     break;
     
     case 10:
       blocks.add( new block( x, y, 0, size, yaw, 0*size, 2*size, 2*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 0*size, -2*size,  2*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 0*size, 0*size,  0*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 0*size, 1*size,  1*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 0*size, -1*size,  1*size ) ); 
     break;
     
     case 11:
     
       blocks.add( new block( x, y, 0, size, yaw, 0*size, 0*size,  0*size ) );
       
       blocks.add( new block( x, y, 0, size, yaw, -1*size, 1*size,  1*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, -1*size, -1*size,  1*size ) );
       
       blocks.add( new block( x, y, 0, size, yaw, -1*size, 1*size,  -1*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, -1*size, -1*size,  -1*size ) ); 
       
       blocks.add( new block( x, y, 0, size, yaw, 1*size, 1*size,  1*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 1*size, -1*size,  1*size ) ); 
       
       blocks.add( new block( x, y, 0, size, yaw, 1*size, 1*size,  -1*size ) ); 
       blocks.add( new block( x, y, 0, size, yaw, 1*size, -1*size, -1*size ) ); 
       
     break;
     case 12:
     //tower
       blocks.add( new block( x, y, 0, size, yaw, 0*size, 0*size,  0*size ) );
       
       blocks.add( new block( x, y, 0, size, yaw, -1*size, -1*size,  1*size ) );
       blocks.add( new block( x, y, 0, size, yaw, -1*size, -1*size,  -1*size ) );
       blocks.add( new block( x, y, 0, size, yaw, 1*size, -1*size,  1*size ) );
       blocks.add( new block( x, y, 0, size, yaw, 1*size, -1*size,  -1*size ) );
       
       blocks.add( new block( x, y, 0, size, yaw, 0*size, 1*size,  0*size ) );    
       blocks.add( new block( x, y, 0, size, yaw, 0*size, 2*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, 0*size, 3*size,  0*size ) );
     

       
     break;
     case 13:
     //peace
       blocks.add( new block( x, y, 0, size, yaw, 0*size, 0*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, -1*size, 0*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, 1*size, 0*size,  0*size ) );
       
       blocks.add( new block( x, y, 0, size, yaw, 1*size, 1*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, -1*size, 1*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, 1*size, 2*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, -1*size, 2*size,  0*size ) );
       
       blocks.add( new block( x, y, 0, size, yaw, 0*size, -1*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, -1*size, -1*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, 1*size, -1*size,  0*size ) );
       
       blocks.add( new block( x, y, 0, size, yaw, 0*size, -1*size,  1*size ) );
       blocks.add( new block( x, y, 0, size, yaw, -1*size, -1*size,  1*size ) );
       blocks.add( new block( x, y, 0, size, yaw, 1*size, -1*size,  1*size ) );
     
     
       
     break;
     case 14:
     //
       blocks.add( new block( x, y, 0, size, yaw, 0*size, 0*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, -1*size, 0*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, 1*size, 0*size,  0*size ) );
       
       blocks.add( new block( x, y, 0, size, yaw, 1*size, 1*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, -1*size, 1*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, 1*size, 2*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, -2*size, 2*size,  0*size ) );
       
       blocks.add( new block( x, y, 0, size, yaw, 0*size, -1*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, -1*size, -1*size,  0*size ) );
       blocks.add( new block( x, y, 0, size, yaw, 1*size, -1*size,  0*size ) );
       
       blocks.add( new block( x, y, 0, size, yaw, 0*size, -1*size,  1*size ) );
       blocks.add( new block( x, y, 0, size, yaw, -1*size, -1*size,  1*size ) );
       blocks.add( new block( x, y, 0, size, yaw, 1*size, -1*size,  1*size ) );
       
     break;
     case 15:
       blocks.add(new block( x, y, 0, size, yaw, 0, 0, 0 ));   
       blocks.add(new block( x, y, 0, size, yaw, 1* size, 0, 0));
       blocks.add(new block( x, y, 0, size, yaw, 2* size, 0, 0));
       
       blocks.add(new block( x, y, 0, size, yaw, 0, 1* size, 0));
       blocks.add(new block( x, y, 0, size, yaw, 2* size, 1* size, 0));
       
       blocks.add(new block( x, y, 0, size, yaw, 0, 2* size, 0));
       blocks.add(new block( x, y, 0, size, yaw, 1* size, 2* size, 0));
       blocks.add(new block( x, y, 0, size, yaw, 2* size, 2* size, 0));
       
       blocks.add(new block( x, y, 0, size, yaw, 0*size, 0* size, -1 * size));
       blocks.add(new block( x, y, 0, size, yaw, 0* size, 0* size, -2* size));
       blocks.add(new block( x, y, 0, size, yaw, 0* size, 0* size, -3* size));
       
     break;
    } 
  }
  
  public void setAngle(float y, float p){
      yaw = y;
      pitch = p;
  }
  
  public void SetSelected(int mX, int mY){
    
    selected = abs(x - mX) < 30 &&  abs(y - mY) < 30;
    
    for(block b : blocks)
      b.setSelected(selected);

  }
  
  public void draw(){
    
    for(block b : blocks){
      b.selected = selected;
      b.hide = hide;
      b.draw(yaw, pitch, timer); 
    }
    
    if(!selected){
      yaw += opposite ? PI/800 : -PI/800 ;
      yaw = yaw % TWO_PI;
       
      pitch += opposite ? PI/800 : -PI/800 ;
      pitch = pitch % TWO_PI;
    }
    
    if(hide){
      
        timer += 0.1f;
        
        if(timer > 1.0f)
          timer = 1.0f;
    }
  }
  float timer = -1.0f;
  boolean hide = false;
  public void hide(){
      println(this + " is hiding");
      hide = true;
  }
    
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "match" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
