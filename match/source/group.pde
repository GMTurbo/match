

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
    opposite = boolean(round(random(0,1)));
    yaw = random(0, PI);
    buildBlock(tp);
  }
  
  void deSelectAll() { 
    for(block b: blocks) { b.selected = false;}
  }
  
  void buildBlock(int type){
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
  
  void setAngle(float y, float p){
      yaw = y;
      pitch = p;
  }
  
  void SetSelected(int mX, int mY){
    
    selected = abs(x - mX) < 30 &&  abs(y - mY) < 30;
    
    for(block b : blocks)
      b.setSelected(selected);

  }
  
  void draw(){
    
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
      
        timer += 0.1;
        
        if(timer > 1.0)
          timer = 1.0;
    }
  }
  float timer = -1.0;
  boolean hide = false;
  void hide(){
      println(this + " is hiding");
      hide = true;
  }
    
}
