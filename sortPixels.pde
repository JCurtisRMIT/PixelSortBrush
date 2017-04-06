class sortPixels {
  //GLOBAL VARs
  int mX = constrain(mouseX, 0+w/2, Img.width-w/2);
  int mY = constrain(mouseY, 0+w/2, Img.height-w/2); 
  int sortLength;
  
  //CONSTRUCTOR
  sortPixels(){}
  
  //FUNCTIONS
  void run(){
    if (axis > 0){ // << X Axis sort
 
  sortLength = (drip > 0) ? int(random(modaX, modoX)-modaX) : (modoX-modaX); // "?" style conditional!
 
  color[] unsortedX = new color[sortLength];
  color[] sortedX = new color[sortLength];  
 
  int offset = mX - (sortLength/2);
  if(drip < 1){offset = 0;}
  
  for (int i = 0; i < sortLength; i++){ 
     Img.loadPixels();
     if(drip>0){
     unsortedX[i] = Img.pixels[(mY*Img.width)+i+modaX];}
     else{unsortedX[i] = Img.pixels[(mY*Img.width)+i+modaX];}
  }
  for (int x = 0; x < sortLength; x++){
   
     sortedX = sort(unsortedX);
     if(rev > 0){sortedX = reverse(sortedX);}
     else{} 
   
  if(drip>0){
     Img.pixels[(mY * Img.width) + x + modaX] = sortedX[x];} 
  else{Img.pixels[(mY * Img.width) + x + modaX] = sortedX[x];}
  Img.updatePixels();
 }

} else { // << Y Axis Sort
   
   sortLength = (drip > 0) ? int(random(modaY, modoY)-modaY) : (modoY-modaY); // '?' style conditional
   
   color[] unsortedY = new color[sortLength];
   color[] sortedY = new color[sortLength]; 
   
   int offset = mY - (sortLength/2);
   if(drip < 1){ offset = 0;} 
   
   for (int i = 0; i < sortLength; i++){
     if(i + offset > Img.height){offset = 0 ;}
     Img.loadPixels();
     if(drip>0){unsortedY[i] = Img.pixels[(i+modaY)*Img.width + mX];}
     else{unsortedY[i] = Img.pixels[(i+modaY)*Img.width + mX];}
   }
   for(int y = 0; y < sortLength; y++){
     
   sortedY = sort(unsortedY);
   if(rev > 0){sortedY = reverse(sortedY);}
   else{} 
   
   if(y + offset > Img.height){offset = 0 ;}else{}
   if(drip>0){Img.pixels[(y+modaY)*Img.width + mX] = sortedY[y];} // pixels[y*width+x]
   else{Img.pixels[(y+modaY)*Img.width + mX] = sortedY[y];}
   Img.updatePixels();
   }
 }
  }
}