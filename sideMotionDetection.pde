import java.awt.*;
import gab.opencv.*;
import processing.video.*;

OpenCV opencv;
Capture video;

PVector aveFlow;

void setup() 
{
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  video.start();
  noFill();
}

void draw() 
{  
  background(0);

  stroke(0,200,0);

  opencv.loadImage(video);
 
  opencv.calculateOpticalFlow();
 
  pushMatrix();
 
  translate(video.width,0);
 
  scale(-1,1);
  
  image(video, 0, 0);

  opencv.flip(OpenCV.HORIZONTAL);
 
  translate(0,video.height);

  aveFlow = opencv.getAverageFlowInRegion(0,0,width/4,height/4);

  opencv.drawOpticalFlow();
  
  
 strokeWeight(1);
 
 stroke(255,0,0);
 
 
 popMatrix();

 text(aveFlow.x+"  x , y :"+ aveFlow.y,400,100);

 textSize(20);
 
 fill(250,40,40);

if(aveFlow.x>0.1)
{
  text("SINISTRA!!",10,100);
}
else if(aveFlow.x<-0.1)
{
  
 text("DESTRA!!",230,100);

}
if(aveFlow.y>0.1)
{
   
  text("GIU'!!",100,230);

}

else if(aveFlow.y<-0.1)
{

  text("SU'!!",100,30);

}

textSize(12);

noFill();

}


void captureEvent(Capture c) 
{
  c.read();
}
