int zoom=0;
int rotate=0;
PImage table_texture,ground_texture,background_texture,sweat_texture,jean_texture,coffee_img;
PShape can;
float coffee_amount=20;
float anim_height=0;
float anim_angle=0;
int anim_switch=0;
float anim_speed=3;

void setup(){
  // Texture loading
table_texture = loadImage("img/wood.png");
ground_texture = loadImage("img/ground.jpg");
background_texture = loadImage("img/bg.jpg");
sweat_texture = loadImage("img/cotton_red.jpg");
jean_texture = loadImage("img/jean.png");
coffee_img = loadImage("img/coffee.jpeg");
size(1000,500,P3D);



}
void createCups(){
pushMatrix();
  can = createCoffeeCup(20, 40, 16, 5,coffee_img);
  float xSpeed =anim_height*2.5;
  float ySpeed = anim_height*2;
  float zSpeed = anim_height*1.2;
  
  translate(-80,-30,30);
  
  translate(-xSpeed,-ySpeed,-zSpeed);
  rotateX(radians(270));
  rotateZ(radians(anim_angle/2));
  shape(can);
  rotateZ(radians(-anim_angle/2));
  rotateX(radians(-270));
  translate(xSpeed,ySpeed,zSpeed);
  
  translate(160,0,-60);
  translate(xSpeed,-ySpeed,zSpeed);
  rotateX(radians(270));
  shape(can);
  rotateX(radians(-270));
  translate(-xSpeed,ySpeed,-zSpeed);
popMatrix();
}

void draw(){
  background(255);
  fill(100);
  strokeWeight(0.5);
  createGround(); // placing ground texture
  createBackground(); // cafe image background
  rotation(); // mouse zoom and rotation function
  createTable(); //placing table
  createChair(); // placing 1st chair
  createGuy(); // creating 1st guy
  rotateY(radians(180));
  createChair(); // placing 2nd chair
  createGuy(); // creating 2nd guy
  
  createCups();

  if(coffee_amount>0){ // animation goes here...

    if(anim_switch==0){
       if(anim_angle<80)
         anim_angle+=.1*anim_speed; 
       else 
         anim_switch=1;
    if(anim_height<35) anim_height+=.05*anim_speed;
   
    }else{
         if(anim_angle>0)
         anim_angle-=.1*anim_speed; 
       else 
         anim_switch=0;
    if(anim_height>0) anim_height-=.05*anim_speed;
    }
   coffee_amount-=.005;
  }
  
  
  
  if(keyPressed){
    if(keyCode==DOWN){
      coffee_amount-=.1 ;   
      print(coffee_amount);
    }
  }
 
  
  
  
}

// Viewing Stuff
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e>0) zoom-=10;else zoom+=10;
}
void rotation(){
  translate(width/2,height/1.4,zoom-100);
  if(mousePressed)
    rotate = mouseX-(width/2);
  rotateY(radians(rotate));
}

// 3D Modelling
void createGround(){
  pushMatrix();
  translate(850,580,0);
  rotateX(radians(90));
  _plane(2500,700,ground_texture);
  popMatrix();
}
void createBackground(){
 pushMatrix();
  translate(500,-580,-1500);
  _plane(2500,1500,background_texture);
  popMatrix();

}
void createTable(){
   pushMatrix();
  //table
  _box(150,10,100,920,613,table_texture);
  translate(0,110,0);
  _box(50,100,50,920,613,table_texture);
  popMatrix();
}

void createChair(){
  strokeWeight(0.5);
  pushMatrix();
  translate(240,150,40);
  _box(10,60,10,920,613,table_texture);
  translate(80,0,0);
  _box(10,60,10,920,613,table_texture);
  translate(0,0,-80);
  _box(10,60,10,920,613,table_texture);
  translate(-80,0,0);
  _box(10,60,10,920,613,table_texture);
  translate(40,-60,35);
  _box(60,2,60,920,613,table_texture);
  translate(58,-62,0);
  rotateZ(radians(90));
  _box(60,2,60,920,613,table_texture);
  rotateZ(radians(-90));
  popMatrix();
}
void createGuy(){
  strokeWeight(0.5);
  pushMatrix();
  //first guy
  translate(285,0,0);
  _box(50,50,50,1500,1000,sweat_texture);
  translate(0,70,0);
  _box(50,20,50,1500,1000,jean_texture);
    translate(-60,-100,70);
  _box(50,20,20,1500,1000,sweat_texture);
  translate(-100,0,0);

  _box(50,20,20,1500,1000,sweat_texture);
 
  translate(0+anim_height*2,-anim_height*1.2,-140+(anim_height));
    rotate(radians(anim_angle));
    rotateY(radians(anim_angle/1.5));
  _box(50,20,20,1500,1000,sweat_texture);
   rotateY(radians(-anim_angle/1.5));
    rotate(radians(-anim_angle));
   
  translate(100-(anim_height*2),anim_height*1.2,-anim_height);
  
  _box(50,20,20,1500,1000,sweat_texture);
 

  translate(-30,100,40);

  _box(40,20,20,1500,1000,jean_texture);
  translate(-20,80,0);
  rotate(radians(90));
  _box(60,20,20,1500,1000,jean_texture);
  rotate(radians(-90));
  translate(20,-80,60);
  _box(40,20,20,1500,1000,jean_texture);
  translate(-20,80,0);
  rotate(radians(90));
  _box(60,20,20,1500,1000,jean_texture);
  rotate(radians(-90));
  translate(115,-250,-20);
  strokeWeight(0);
  fill(189);
  sphere(50);
  //second guy
  
  popMatrix();

}

void _plane(int x, int y,PImage texture) {
  beginShape();
  textureMode(NORMAL);
  texture(texture);
  vertex(-x, -y, 0, 0, 0);
  vertex(-x, y, 0, 0, 1);
  vertex(x, y, 0, 1, 1);
  vertex(x, -y, 0, 1, 0);
  endShape(CLOSE);
}

void _box(int x,int y,int z,float u,float v, PImage texture){
  textureMode(IMAGE);
  beginShape(QUADS);
  texture(texture);
  //surface1
  vertex(-x,  y,  z,0,0);
  vertex( x,  y,  z,u,0);
  vertex( x, -y,  z,u,v);
  vertex(-x, -y,  z,0,v);
  //surface2
  vertex( x,  y,  z,0,0);
  vertex( x,  y, -z,u,0);
  vertex( x, -y, -z,u,v);
  vertex( x, -y,  z,0,v);
  //surface3
  vertex( x,  y, -z,0,0);
  vertex(-x,  y, -z,u,0);
  vertex(-x, -y, -z,u,v);
  vertex( x, -y, -z,0,v);
  //surface4
  vertex(-x,  y, -z,0,0);
  vertex(-x,  y,  z,u,0);
  vertex(-x, -y,  z,u,v);
  vertex(-x, -y, -z,0,v);
  //surface5
  vertex(-x,  y, -z,0,0);
  vertex( x,  y, -z,u,0);
  vertex( x,  y,  z,u,v);
  vertex(-x,  y,  z,0,v);
  //surface6
  vertex(-x, -y, -z,0,0);
  vertex( x, -y, -z,u,0);
  vertex( x, -y,  z,u,v);
  vertex(-x, -y,  z,0,v);
  endShape(CLOSE);
}

PShape createCoffeeCup(float r, float h, int sides, int thickness,PImage img) {
  textureMode(NORMAL);
  PShape cup = createShape(GROUP);
  
  float angle = 360.0 / sides;  
  float halfHeight = h / 2;
  
  // Create topLid

  
  // Create inner sides
  PShape innerSides = createShape();
  innerSides.beginShape(QUAD_STRIP);
  innerSides.noStroke();
  for (int i = 0; i <= sides; ++i) {
    float x = cos(radians(i * angle)) * (r - thickness);
    float y = sin(radians(i * angle)) * (r - thickness);
    float u = float(i) / sides;
    innerSides.vertex(x, y, halfHeight - thickness, u, 1);
    innerSides.vertex(x, y, -coffee_amount, u, 0);
  }
  
  innerSides.endShape(CLOSE);
  innerSides.setFill(color(#964B00));
  cup.addChild(innerSides);
  
  // Create inner bottom
  PShape innerBottom = createShape();
  innerBottom.beginShape();
  innerBottom.noStroke();
  for (int i = 0; i != sides; ++i) {
    float x = cos(radians(i * angle)) * (r - thickness);
    float y = sin(radians(i * angle)) * (r - thickness);
    innerBottom.vertex(x, y, halfHeight - thickness);
  }
  innerBottom.endShape();
  cup.addChild(innerBottom);
  
  // Create outer sides
  PShape outerSides = createShape();
  outerSides.beginShape(QUAD_STRIP);
  outerSides.noStroke();
  noStroke();
  outerSides.texture(img);
  textureWrap(CLAMP);
  for (int i = 0; i <= sides; ++i) {
    float x = cos(radians(i * angle)) * r;
    float y = sin(radians(i * angle)) * r;
    float u = float(i) / sides;
    outerSides.normal(x, y, 0);
    outerSides.vertex(x, y, halfHeight, u, 1);
    outerSides.vertex(x, y, -halfHeight, u, 0);
  }
  outerSides.endShape(CLOSE);
  cup.addChild(outerSides);
  
  // Create outer bottom
  PShape outerBottom = createShape();
  outerBottom.beginShape();
  outerBottom.noStroke();
  for (int i = 0; i != sides; ++i) {
    float x = cos(radians(i * angle)) * r;
    float y = sin(radians(i * angle)) * r;
    outerBottom.vertex(x, y, halfHeight);
  }
  outerBottom.endShape();
  cup.addChild(outerBottom);
  strokeWeight(0.5);
  return cup;
}
