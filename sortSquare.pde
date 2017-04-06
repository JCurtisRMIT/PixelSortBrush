class sortSquare {
  //GLOBAL VARs
  int mX = constrain(mouseX, 0+w/2, Img.width-w/2);
  int mY = constrain(mouseY, 0+w/2, Img.height-w/2); 
  int xlen = xend - xstart;
  int ylen = yend - ystart;
  int sortLength;
  
  //CONSTRUCTOR
  sortSquare(){}
  
  //FUNCTIONS
  void run(int xstart,int ystart,int xend,int yend,int axis){
    int xlen = xend - xstart;
    int ylen = yend - ystart;
    int sortLength;
    switch(axis){
      case 0: // y_axis sort 
      for(int xx = 0; xx < xlen; xx++){
        sortLength = (drip > 0) ? int(random(ystart, Img.height)-ystart) : yend-ystart; 
        color[] unsorted = new color[sortLength];
        color[] sorted = new color[sortLength]; 
        for (int i = 0; i < sortLength; i++){ 
          Img.loadPixels();
          if(drip>0){unsorted[i] = Img.pixels[((i+ystart)*Img.width)+(xstart+xx)];}  
          else{unsorted[i] = Img.pixels[((i+ystart)*Img.width)+(xstart+xx)];}
        }
        for (int x = 0; x < sortLength; x++){
        
          sorted = sort(unsorted);
          if(rev > 0){sorted = reverse(sorted);}
          else{} 
       
          if(drip>0){Img.pixels[((x+ystart) * Img.width) + (xx + xstart)] = sorted[x];} 
          else{Img.pixels[((x+ystart) * Img.width) + (xx + xstart)] = sorted[x];}
          Img.updatePixels();
        }
      }
      break;
      
      case 1: // x_axis sort
      for(int yy = 0; yy < ylen; yy++){
          sortLength = (drip > 0) ? int(random(xstart, Img.width)-xstart) : xend-xstart; 
          color[] unsorted = new color[sortLength];
          color[] sorted = new color[sortLength]; 
          for (int i = 0; i < sortLength; i++){ 
            Img.loadPixels();
            if(drip>0){unsorted[i] = Img.pixels[((yy+ystart)*Img.width)+(xstart+i)];}  
            else{unsorted[i] = Img.pixels[((yy+ystart)*Img.width)+(xstart+i)];}
          }
           for (int x = 0; x < sortLength; x++){
             
             sorted = sort(unsorted);
             if(rev > 0){sorted = reverse(sorted);}
             else{} 
             
             if(drip>0){Img.pixels[((yy+ystart) * Img.width) + (x + xstart)] = sorted[x];} 
             else{Img.pixels[((yy+ystart) * Img.width) + (x + xstart)] = sorted[x];}
             Img.updatePixels();
         }
      }
      break;
    }
    Img.updatePixels();
}
}