
import ddf.minim.*;
//import damkjer.ocd.*;

ArrayList<String> runTimes = new ArrayList<String>();

ArrayList<group> groups = new ArrayList<group>();

boolean saveGif = false;
int gifFrameCount = 0;

Minim minim;
AudioPlayer player;
AudioPlayer match;
AudioPlayer error;
//AudioInput input;
//Camera camera1;
int startingTime = 0;
int endTime = 0;

PFont runningFont = createFont("Helvetica Neue", 256, true);//Helvetica Neue;

void setup(){
  
  size(600, 850, P3D);
  minim = new Minim(this);
  player = minim.loadFile("closed.mp3");
  //player.setVolume(0.5);
  player.setGain(-15.0);
  println(player.getControls());
  match = minim.loadFile("matched.mp3");
  match.setGain(-6.0);
  //error = minim.loadFile("error.mp3");
  player.loop();
  player.play();
  //input = minim.getLineIn();
  
  //
  //camera1.aim(width/2, height/2, 0);
//PFont font= createFont("Chalet", 256, true);//Helvetica Neue
  //textFont(font);
  //runTimes.add("TEST");
  //back = loadImage("cube.jpg");
  //back.resize(2*width, 2*height);
  initialize();
}

void stop()
{
  player.close();
  match.close();
  error.close();
  
  minim.stop();
  super.stop();
}

int uidStep = 0;

boolean alreadyHasTwo(int number, int[][] checkArray, int rows, int cols){
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

PFont chalet = createFont("Chalet", 256, true);

void initialize(){
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
   
   int stepX = ceil(float(width)/float(boardX));
   int stepY = ceil(float(height)/float(boardY));
   
   for(int i = 0 ; i < boardX; i ++){
     for( int j = 0 ; j < boardY; j++){
       
       uidStep += int(random(uidStep, uidStep+5));
       
       group g = new group(60 + i*stepX, 50+j*stepY, uidStep, typeArray[i][j]);
       
       groups.add(g);
       println(groups.size());
       
     }
   }
}

boolean canAdd(group check){
    
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

void draw(){
  
   if(showMenu && !firstMouseDown){
      rotateClock+=0.1;
      rotateClock = rotateClock > 1.0 ? 1.0 : rotateClock;
   }else{
      
      rotateClock-=0.1;
      rotateClock = rotateClock > 0 ? rotateClock : 0.0;
   }
   
   rotateY(rotateClock*PI/2);
   
   //smooth(4);
   
   background(255); 
   
   lights();
   
    float t = (endTimer > 1.0) ? 1.0 : endTimer;
    
  // draw time
   if(firstMouseDown){
     
     int seconds = ((ended ? endTime : millis()) - startingTime) / 1000;
     int minutes = seconds / 60;
     int hours = minutes / 60;
     seconds -= minutes * 60;
     minutes -= hours * 60;
     fill(0);
     stroke(0);
     
     fill(20, 20, 20, ended ? 50 + t * 205 : 50);
     
      textAlign(LEFT);
      textFont(runningFont);
     if(ended) {
       textSize(80);
       text("Finished",width/2 - 140,height/2 - 155, -50 + t*150);
       textSize(256);
     }
     
     text(( minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds),width/2 - 240,height/2 + 40, -50 + t * 150);
       
     
   }else{
     
    textFont(chalet,80);
    textAlign(LEFT);
    fill(0, 128);
    //textSize(80);
    text("Match", width/2 - 110, height/2 , -50); 
    
   }
   
    textFont(chalet,80);
    //textSize(80);
    textAlign(LEFT);
    fill(0, 12 - 12*t);
    for(float i = 0 ; i < width; i+=float(width)/2.5 ){
     for(int j = 0 ; j < height; j+=float(height/12)){
         text("Match", round(i) - 49, j+5, -50); 
     }
    }
   
   stroke(0);
   strokeWeight(2);
   
   rect(mouseX + 5/2, mouseY + 5/2, 5, 5);
   
   for(group g : groups){
      g.draw(); 
   }
   
   if(endTimer > 2.8 && ended){
      println("end sequence is done");
      endTimer = 0;
      ended = false;
      initialize(); 
   }else if(ended){ 
     endTimer += 0.01;
   }
   
   //show scores
   textFont(chalet, 80);
   //textSize(40);
   rotateY(-PI/2);
   translate(0,0,-width);
   //fill(128,128);
   stroke(0);
   //rect(20,0, width, height);
   fill(0);
   textAlign(LEFT);
   text("History", 30, 20);
   int yoffset = 150;
   
   for(String s : runTimes){
       text(s, 70, yoffset+=120);
   }
   
   rotateY(-PI/2);
   
   if(saveGif){
      if(frameCount%2 == 0)
        saveFrame("gif" + (gifFrameCount++) + ".png");
  }
     
}

float endTimer = 0;
boolean ended = false;
boolean showMenu = false;
float rotateClock = 0;

void keyPressed(){
   switch(key){
      case 'c': //center
      initialize();
      break;
      case 's':
      saveFrame("screenCap" + (screenCap++) + ".png");
      println("saved screenshot: " + screenCap);
      break;
   } 
   
   switch(keyCode){
     case CONTROL:
      showMenu = !showMenu;
      if(showMenu) rotateClock = 0;
     break; 
   }
   
}

int screenCap = 0;

void mouseClicked(){
   for(group g: groups) 
     g.deSelectAll(); 
}

boolean somethingSelected = false;

group current = null;
group selectedGroup1 = null;
group selectedGroup2 = null;
int selectedCount = 1;
void mousePressed(){
  
  if(!firstMouseDown && !showMenu){
     firstMouseDown = true;
     textFont(runningFont);
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
       int seconds = (endTime - startingTime) / 1000;
       int minutes = seconds / 60;
       int hours = minutes / 60;
       seconds -= minutes * 60;
       minutes -= hours * 60;
       runTimes.add("Duration: " + minutes + ":" + (seconds < 10 ? "0" + seconds : seconds));
       println("game ended");
       ended = true;
     }
     
  }
}

void compareGroups(group g1, group g2){
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

void mouseReleased(){
  //somethingSelected = false;
  //selectedGroup1 = null;
    //for(group g: groups) { 
    //g.selected = false;
  //}
}

void mouseDragged() {
  
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

void mouseMoved(){
  if(keyPressed && keyCode == CONTROL){
      //println("zooming");
     // camera1.zoom(radians(mouseY - pmouseY) / 2.0);
    }
}
