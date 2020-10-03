import processing.video.*;

Movie Original,fps15,fps1,speedx2;
float timer1 = 0;
float timer2 = 0;
float delay1 = 1000/15f; // 15 fps
float delay2 = 1000/1f; // 1 fps


void setup() {
  size(1490, 1000);
  noStroke();

  Original = new Movie(this, "Video.mov");
  Original.loop();
 
  fps15 = new Movie(this, "Video.mov");
  fps15.loop();
  
  fps1 = new Movie(this, "Video.mov");
  fps1.loop();
  
  speedx2 = new Movie(this, "Video.mov");
  speedx2.loop();
  speedx2.speed(2.0); 
  
}

void draw() {
  image(Original, 0, 0);
  image(fps15, Original.width+50, 0);
  image(fps1, 0, Original.height+50);
  image(speedx2, Original.width+50, Original.height+50);
  Original.read();
  speedx2.read();
  if( millis() > timer1 ){
    fps15.read();
    timer1+=delay1;
  }
  
  if( millis() > timer2 ){
    fps1.read();
    timer2+=delay2;
  }
}
