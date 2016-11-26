import ketai.camera.*;
color trackColor; 
KetaiCamera cam;

/*
void setup() {
  orientation(LANDSCAPE);
  imageMode(CENTER);
  cam = new KetaiCamera(this, 320, 240, 24);
}  
*/  
void setup() {
  trackColor = color(255,0,0);
   smooth();
  size(720,480);
  cam = new KetaiCamera(this,720,480,30);
  //image(cam,width, height);
  //cam.resize(1440,2560);
  imageMode(CENTER);
  background(255,0,0);
  orientation(LANDSCAPE);
 
}


void draw() {
  
  
  image(cam,width/2, height/2,720,480);
   cam.start(); 
//  cam.loadPixels();
  println(cam.width);
  
    
    float worldRecord = 500; 

  // XY coordinate of closest color
  int closestX = 0;
  int closestY = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < cam.width; x ++ ) {
    for (int y = 0; y < cam.height; y ++ ) {
      int loc = x + y*cam.width;
      // What is current color
      color currentColor = cam.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      // Using euclidean distance to compare colors
      float d = dist(r1,g1,b1,r2,g2,b2); // We are using the dist( ) function to compare the current color with the color we are tracking.

      // If current color is more similar to tracked color than
      // closest color, save current location and current difference
      if (d < worldRecord) {
        worldRecord = d;
        closestX = x;
        closestY = y;
      }
    }
  }

  // We only consider the color found if its color distance is less than 10. 
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  if (worldRecord < 50) { 
    // Draw a circle at the tracked pixel
    fill(trackColor);
    strokeWeight(4.0);
    stroke(0);
    ellipse(closestX,closestY,100,100);
    
   // println(closestX);
   // 
    
  }    
    
}



void onCameraPreviewEvent()
{
    
  cam.read();

}

void exit() {
  cam.stop();
}



void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable
  int loc = mouseX + mouseY*cam.width;
  trackColor = cam.pixels[loc];
}