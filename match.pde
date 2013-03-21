import damkjer.ocd.*;

ArrayList<group> groups = new ArrayList<group>();

Camera camera1;
void setup(){
  
  size(700,700, P3D);
  
  //smooth();
  camera1 = new Camera(this, width/2, height/2, 500);
  camera1.aim(width/2, height/2, 0);
  initialize();
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
void initialize(){
  //int offsetX = 
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
       
       group g = new group(50 + i*stepX, 50+j*stepY, uidStep, typeArray[i][j]);
       
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

void draw(){
  
   background(255); 
   lights();
   //camera1.feed();

   
   stroke(0);
   strokeWeight(2);
   rect(mouseX + 5/2, mouseY + 5/2, 5, 5);
   
   for(group g : groups){
      
      g.draw(); 
   }
     
}

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
     
     if(done)
       exit();
     
  }
}

void compareGroups(group g1, group g2){
   // if they are the same things then make them disappear and maybe do some text stuff
  if(g1.id == g2.id && g1 != g2){
     g1.hide();
     g2.hide();
     //showScore();
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
      camera1.track(pmouseX - mouseX, pmouseY - mouseY);
    }
    else if(mouseButton == RIGHT)
      camera1.look(radians(mouseX - pmouseX) / 2.0, radians(mouseY - pmouseY) / 2.0); 
  }
}

void mouseMoved(){
  if(keyPressed && keyCode == CONTROL){
      //println("zooming");
      camera1.zoom(radians(mouseY - pmouseY) / 2.0);
    }
}
