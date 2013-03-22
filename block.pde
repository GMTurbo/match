
class block{
  
   color c;
   color cc;
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
    int v = int(random(90, 255));
    
    c = color(v, v, v);
    cc = color(int(random(10, 240)),int(random(10, 240)),int(random(10, 240)));
      
   }
   
   void setSelected(boolean state){
     selected = state;
   } 
   
   boolean hide = false;
   
   void hide(){
       hide = true;
       selected = false;
   }
   
   float clock = -TWO_PI;
   
   void draw(float yaw, float pitch, float timer){
     
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
         
         if(timer==1.0){
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
       rotateY(clock);
       
       translate(rotateX, rotateY, rotateZ);
       fill(selected ? color(cc, 90) : cc);
       if(selected)
         stroke(color(125,223,252));
       else
         noStroke();//stroke(0);
       strokeWeight(selected ? 1.0 : 0.5);
       
       box(size);
       
       popMatrix();
     }
     
     clock += PI/800;
     clock = clock%TWO_PI;
      
   } 
}
