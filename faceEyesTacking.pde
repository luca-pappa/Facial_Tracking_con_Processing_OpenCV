import gab.opencv.*;
import processing.video.*;
import java.awt.*;


Capture video;
OpenCV opencv;

 void setup() 
 { 
  size(640, 480);
  
  video = new Capture(this, width/2, height/2);
  
  opencv = new OpenCV(this, width/2, height/2);
 
  video.start();
  
 }

 void draw() 
 {
  
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();

  stroke(0, 255, 0);

  strokeWeight(1);
 
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
 
  Rectangle[] faces = opencv.detect();
 
  opencv.loadCascade(OpenCV.CASCADE_EYE);     
  
  Rectangle[] eyes = opencv.detect();

  if(faces.length==1) 
    {
      
       text("face",faces[0].x, faces[0].y);
       
       ellipse(faces[0].x+faces[0].width/2, faces[0].y+faces[0].height/2, faces[0].width, faces[0].height);
       
      
      if(eyes.length==2)
       {
             int eyesXd=abs(eyes[0].x- eyes[1].x);
      
             int eyesYd=abs(eyes[0].y- eyes[1].y);
   
          //se la distanza X tra gli occhi è < di 30 px  e la distanza Y < 20 e gli occhi stanno dentro la faccia sia per x 
          //che per y 
          if((eyesXd>30) && (eyesYd<20) && (faces[0].x<eyes[0].x) && (faces[0].x<eyes[1].x)
          && ((faces[0].x+faces[0].width)>eyes[0].x) && (faces[0].x+faces[0].width)>eyes[1].x
          &&((faces[0].y+faces[0].height)>eyes[0].y) && (faces[0].y+faces[0].height)>eyes[1].y)
          
          {
             //qual' è l'occhio destro?
           if(eyes[0].x> eyes[1].x)
            {
              
                 text("sx",eyes[0].x, eyes[0].y); 
      
                 text("dx",eyes[1].x, eyes[1].y); 
          
            }
           else
           {
                text("dx",eyes[0].x, eyes[0].y); 
      
                text("sx",eyes[1].x, eyes[1].y); 
           
           }
       //    disegno dei cerchi sugli occhi
             ellipse(eyes[0].x+eyes[0].width/2, eyes[0].y+eyes[0].height/2, eyes[0].width/2, eyes[0].height/2);
      
             ellipse(eyes[1].x+eyes[1].width/2, eyes[1].y+eyes[1].height/2, eyes[1].width/2, eyes[1].height/2);
             
          }
         
        }
       //se vedo un solo occhio
       
       if(eyes.length==1)
         {
             
          if((faces[0].x<eyes[0].x)
          //meta faccia destra
          &&  (eyes[0].x<(faces[0].x+faces[0].width/2))
           && (faces[0].y<eyes[0].y)
           // meta in su
           && (eyes[0].y<(faces[0].y+faces[0].height/2)))
         {  
             text("dx",eyes[0].x, eyes[0].y); 
         
         }
           if((faces[0].x<eyes[0].x)
          //meta faccia sinistra
          &&  (eyes[0].x>(faces[0].x+faces[0].width/2))
           && (faces[0].y<eyes[0].y)
           // meta in su
           && (eyes[0].y<(faces[0].y+faces[0].height/2)))
           {
             text("sx",eyes[0].x, eyes[0].y);   
           }
        //disegno un cerchio sull'occhio     
             ellipse(eyes[0].x+eyes[0].width/2, eyes[0].y+eyes[0].height/2, eyes[0].width/2, eyes[0].height/2);
        //e centro l'iride        
             ellipse(eyes[0].x+eyes[0].width/2, eyes[0].y+eyes[0].height/2, 2,2);
             
       }
    }
}

void captureEvent(Capture c) 
{
  c.read();
}
