//PixelSortBrush v1.0 
//J.Curtis RMIT University || April 2017

//Declare classes and global vars

sortPixels sort;
sortSquare sortSq;
sortTriangle sortTri;

PFont AvenirHeavy;
PImage Img; 

int rndor = (int)random(255);
int rndog = (int)random(255);
int rndob = (int)random(255);

int mainCode = 0;
int saveNumber = 0;
int w = 80;
int drip = 1;
int rev = 0;
int modctrl = 0;
int modoffset = 0;

int modaX = 0;
int modaY = 0;
int modoX = 0;
int modoY = 0;

int sortLength = 0;
int brushType = 0; 
int sortMode = 0; 
int sortType = 0;
int driprangeX = 0;
int driprangeY = 0;

int xstart = 0;
int ystart = 0;
int xend = 0;
int yend = 0;


String helpfile = "[1] [2] [3] to change brushes";
String helpfile01 = "[d] for dripmode . [r] for reverse sort";
String helpfile02 = "[Scrollwheel] up/down to change brushsize";
String helpfile03 = "Use [Ctrl] to toggle range selector movement";
String helpfile04 = "[Leftclick] to sort . [Rightclick] to change axes";
String helpfile05 = "[s] to save image";
String helpfile06 = "[h] for help";

int axis = 0;
int keyvalue = 0;
int s = 50;
color c = 0;

void setup(){
    size (640,480); 
    AvenirHeavy = createFont("Avenir-Heavy", 23);
    textFont(AvenirHeavy);
    textAlign(CENTER);
    smooth();
    mouseX = 320;
    mouseY = 240;
}


void draw(){
    if (mainCode < 1){
      welcomeScreen();  
    } else { // mainCode = true
      
      sort = new sortPixels();
      sortSq = new sortSquare();
      sortTri = new sortTriangle();
      
      textFont(AvenirHeavy);
      frameRate(60);
      surface.setResizable(true);
      surface.setSize(Img.width, Img.height);
      Img.loadPixels();
      image(Img, 0, 0);
      Img.updatePixels(); 

      color c = Img.get(mouseX, mouseY); 
      color cgs = (int)brightness(Img.get(mouseX, mouseY));
      
      color ccx1 = Img.get(modaX, mouseY);
      int cx1 = (int)brightness(ccx1);
      color ccx2 = Img.get(modoX, mouseY);
      int cx2 = (int)brightness(ccx2);
      color ccy1 = Img.get(mouseX, modaY);
      int cy1 = (int)brightness(ccy1);
      color ccy2 = Img.get(mouseX, modoY);
      int cy2 = (int)brightness(ccy2);

      color cgsopp = (cgs > 120) ? 0 : 255;
      color oppx1 = (cx1 > 120) ? 0 : 255;
      color oppx2 = (cx2 > 120) ? 0 : 255;
      color oppy1 = (cy1 > 120) ? 0 : 255;
      color oppy2 = (cy2 > 120) ? 0 : 255;
      
      int xstart = constrain(mouseX-w/2,0,Img.width);
      int ystart = constrain(mouseY-w/2,0,Img.height);
      int xend = constrain(mouseX+w/2,0,Img.width);
      int yend = constrain(mouseY+w/2,0,Img.height);
     
      int mX = constrain(mouseX, 0+w/2, Img.width-w/2);
      int mY = constrain(mouseY, 0+w/2, Img.height-w/2); 
      
      int tristart = constrain(mY-w/2,0,Img.height);
      int trileft = constrain(mX-w/2,0,Img.width);
      int triright = constrain(mX+w/2,0,Img.width);
      int tridist = (int)sqrt(pow(w,2)+pow(w/2, 2));
         
      modaX = constrain(((mX - w/2)+modoffset), 0, mX-1);
      modoX = constrain((mX + w/2)+modoffset, mX, Img.width-1);
      modaY = constrain(((mY - w/2)+modoffset), 0, mY-1);
      modoY = constrain((mY + w/2)+modoffset, mY, Img.height-1); 
       
      //OVERLAY
       
      fill(255);
      textSize(12);
      text(mouseX, 40, 25);
      text("x", 55, 25);
      text(mouseY, 80, 25);
      text("y", 95, 25);
      stroke(255);
      fill(c);
      rect(0, 0, 25, 25);
      noFill();
      stroke(255);
      

      if(axis>0 && brushType < 1){
         stroke(oppx1);
         line(modaX, mouseY - 3, modaX, mouseY + 3);
         stroke(oppx2);
         line(modoX, mouseY - 3, modoX, mouseY + 3);
         stroke(255);
       } else if(axis<1 && brushType < 1) {
         stroke(oppy1);
         line(mouseX - 3, modaY, mouseX + 3, modaY);
         stroke(oppy2);
         line(mouseX - 3, modoY, mouseX + 3, modoY);
         stroke(255);
       } else{}
       
       if(drip>0){
         fill(255);
         text("[drip_mode]", 35, 64);  
       }else{} 
       
       if(rev>0){
         fill(255);
         text("[reverse_sort]", 37, 78); 
       }else{} 
         
       if(axis > 0){fill(255);text("X-Axis Sort", 30, 40);} 
       else{fill(255);text("Y-Axis Sort", 30, 40);}
         
      switch(brushType){
        case 0:
          fill(255);
          text("Row/Column Brush", 55, 50);
          stroke(cgsopp);
          break;
        case 1:
          fill(255);
          text("Squarebrush", 36, 50);
          noFill();
          rect(xstart,ystart,w,w);
          break;
        case 2:
          fill(255);
          text("Triangle Brush", 36, 50);
          noFill();
          triangle(mX,tristart,trileft,mY+w/2-2,triright,mY+w/2-2);
          break;
        
      }
  
       // END OVERLAY

       if (mousePressed && (mouseButton == LEFT)) {  
         switch(brushType) {
           case 0:
             sort.run(); 
             break;
           case 1:
             sortSq.run(xstart, ystart, xend, yend, axis);
             //sortSquare(xstart, ystart, xend, yend, axis);
             break;
           case 2:
             sortTri.run();
             //sortTriangle(tristart, trileft, triright, tridist, axis);
             break;
         } 
       } else {}
        
  }
}




void keyPressed(){ 
  
  if (key == CODED) {
    if (keyCode == CONTROL) {
      modctrl = (modctrl+1)%2;
    } else {}
  }
  
    switch(key){
      case' ' :
        mainCode = 1;
        selectFile();
        break;
      case's': 
      case'S':
        String s = "PBS" + nf(saveNumber,4) +".jpg";
        save(s);
        saveNumber++;
        Img.save(s);
        println("SAVED as" + s);
        break;
      case '1':
      case '2':
      case '3':
      case '4':
        brushType = key-49;
        break;
      case'd':
      case'D':
        drip = (drip+1) %2;
        break;
      case'r':
      case'R':
        if(rev>0){rev = 0;} else {rev = 1;} 
        break;
      case'h':
      case'H':
        mainCode = (mainCode+1)%2;
        break;
    }
}

void mouseWheel(MouseEvent event) {
  float e = event.getAmount();
  if (e>0 && modctrl<1) {
    w++;
  } else if(e>0 && modctrl>0){
    modoffset++;
  } else {}
  if (e<0 && modctrl<1) {
    w--;  
  } else if(e<0 && modctrl>0){
    modoffset--;
  } else {}
}

void mouseReleased(){
    if (mouseButton == RIGHT) {
      axis = (axis + 1) %2;
    } else {}
}

void welcomeScreen(){
  float lfo = map(sin(frameCount*0.01), -1.0, 1.0, 0.0, 1.0);
  if(lfo < 0.003){ rndor = (int)random(255); rndog = (int)random(255); rndob = (int)random(255);  }
  color bg = color(lfo*rndor,lfo*rndog,lfo*rndob);
  background(bg);
  frameRate(30);
  textSize(48);
  fill(rndor/2, rndog/2, rndob/2);
  text("pixelsortbrush v1.0", width/2, 60);
  textSize(30);
  fill(255);
  text("[press space to load image]", width/2, height-20);
  textSize(25);
  fill(200);
  text(helpfile, width/2, 150);
  text(helpfile01, width/2, 180);
  text(helpfile02, width/2, 210);
  text(helpfile03, width/2, 240);
  text(helpfile04, width/2, 270);
  text(helpfile05, width/2, 300);
  text(helpfile06, width/2, 330);
}

void selectFile(){
  selectInput("Select a file to process:", "fileSelected");
  interrupt();
}
  
void fileSelected(File selection) {
  if (selection == null) {
    mainCode = 0;
    println("Window was closed or the user hit cancel.");
    System.exit(0);
} else {
    Img = loadImage(selection.getAbsolutePath());
    println("User selected " + selection.getAbsolutePath());
return;
  }
}

void interrupt() { 
      while (Img==null) delay(5000); 
}