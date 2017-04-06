class sortTriangle {
  //GLOBAL VARs
  int mX = constrain(mouseX, 0+w/2, Img.width-w/2);
  int mY = constrain(mouseY, 0+w/2, Img.height-w/2);  
  
  //CONSTRUCTOR
  sortTriangle(){}
  
  //FUNCTIONS
  void run(){
    switch(axis){
      case 0: // y_axis sort 
      for(int x = 0; x < w/2+1; x++){    
          Img.loadPixels();
          sortLength = x*2; 
          int rando = (drip > 0) ? int(random((mY+w/2), Img.height)-(mY+w/2)) : 0;
          
          color[] unsortedL = new color[sortLength];
          color[] sortedL = new color[sortLength]; 
          color[] unsortedR = new color[sortLength];
          color[] sortedR = new color[sortLength]; 
          
          for (int i = 0; i < sortLength; i++){ 
            Img.loadPixels();
            if(drip>0){unsortedL[i] = Img.pixels[((((mY+w/2)-i)+rando) * Img.width) + ((mX-w/2)+x)];
                       unsortedR[i] = Img.pixels[((((mY+w/2)-i)+rando) * Img.width) + ((mX+w/2)-x)];}  
            else{unsortedL[i] = Img.pixels[((((mY+w/2)-i)+rando) * Img.width) + ((mX-w/2)+x)];
                 unsortedR[i] = Img.pixels[((((mY+w/2)-i)+rando) * Img.width) + ((mX+w/2)-x)];}
            }
           for (int j = 0; j < sortLength; j++){
             sortedL = sort(unsortedL);
             sortedR = sort(unsortedR);
             if(rev == 0){sortedL = reverse(sortedL);sortedR = reverse(sortedR);}
             else{} 
             
             if(drip>0){Img.pixels[((((mY+w/2)-j)+rando) * Img.width) + ((mX-w/2)+x)] = sortedL[j];
                        Img.pixels[((((mY+w/2)-j)+rando) * Img.width) + ((mX+w/2)-x)] = sortedR[j];} 
             else{Img.pixels[((((mY+w/2)-j)+rando) * Img.width) + ((mX-w/2)+x)]=sortedL[j];
                  Img.pixels[((((mY+w/2)-j)+rando) * Img.width) + ((mX+w/2)-x)]=sortedR[j];}
             Img.updatePixels();
          }
        }
      break;
      
      case 1: 
      for(int y = 0; y < w; y++){ // x_axis sort
          sortLength = (drip > 0) ? int(random(mX, Img.width)-mX) : y; 
          color[] unsorted = new color[sortLength];
          color[] sorted = new color[sortLength]; 
          
          for (int i = 0; i < sortLength; i++){ 
            Img.loadPixels();
            if(drip>0){unsorted[i] = Img.pixels[((y+(mY-w/2))*Img.width)+((mX-(y/2))+i)];} //starts from top
            else{unsorted[i] = Img.pixels[((y+(mY-w/2))*Img.width)+((mX-(y/2))+i)];} // starts from top of pyramid
          }
           for (int j = 0; j < sortLength; j++){
             
             sorted = sort(unsorted);
             if(rev == 0){sorted = reverse(sorted);}
             else{} 
             
             if(drip>0){Img.pixels[((y+(mY-w/2)) * Img.width) + (j + (mX-(y/2)))] = sorted[j];} 
             else{Img.pixels[((y+(mY-w/2)) * Img.width) + ((mX-(y/2)) + j)] = sorted[j];}
             Img.updatePixels();
          }
        }
       break;
      }
  }
}