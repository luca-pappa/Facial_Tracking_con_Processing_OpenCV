import gab.opencv.*;
import processing.video.*;
import java.awt.*;

PVector  aveFlow;

Capture video;
OpenCV opencv;
 
 int scale=2;
 
 void setup() 
 { 
  size(1280, 480);
  
  video = new Capture(this, floor(0.5*width/scale), height/scale);
  
  opencv = new OpenCV(this, floor( 0.5*width/scale), height/scale);
 
  video.start();
  
 }

 void draw() 
 {
  
  scale(scale);
  
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();

  stroke(0, 255, 0);

  strokeWeight(1);
 
  opencv.calculateOpticalFlow();
 
  pushMatrix();
 
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
 
  Rectangle[] faces = opencv.detect();
 
  opencv.loadCascade(OpenCV.CASCADE_EYE);     
  
  Rectangle[] eyes = opencv.detect();
 
 //lavoro solo con un viso
  if(faces.length==1) 
    {
      //prendo il movimento solo all'interno della faccia
      aveFlow = opencv.getAverageFlowInRegion(faces[0].x,faces[0].y,faces[0].width,faces[0].height);
      
   // se il flusso è abbastanza grande (>0.5) mi sto spostando
     if(aveFlow.x >0.5)
       text("ti stai spostando A DESTRA",150,230);
       else if(aveFlow.x <-0.5)
       text("ti stai spostando A SINISTRA ",50,230);
        if(aveFlow.y >0.4)     
       text("ti stai muovendo GIU' ",100,240);
       else if(aveFlow.y <-0.4)        
       text("ti stai muovendo SU' ",100,50);
   
   //disegno l'ellisse della faccia   
       ellipse(faces[0].x+faces[0].width/2, faces[0].y+faces[0].height/2, faces[0].width, faces[0].height);
          
      if(eyes.length==2)
       {
           // distanze tra occhi
          if(abs(eyes[0].x- eyes[1].x)>30 &&(abs(eyes[0].y-eyes[1].y)<20))
          {
             
           if(eyes[0].x> eyes[1].x)
            {
              
                 text("sx",eyes[0].x, eyes[0].y); 
                 text("dx",eyes[1].x, eyes[1].y); 
          
            }
           else //entra sempre qui >:-\
            {
                text("dx",eyes[0].x, eyes[0].y); 
                text("sx",eyes[1].x, eyes[1].y); 
              
            }
            //disegno gli occhi
             ellipse(eyes[0].x+eyes[0].width/2, eyes[0].y+eyes[0].height/2, eyes[0].width/2, eyes[0].height/2);
             ellipse(eyes[1].x+eyes[1].width/2, eyes[1].y+eyes[1].height/2, eyes[1].width/2, eyes[1].height/2);
             
          }
         
        }
       
     if(eyes.length==1)
         {
             
          if((faces[0].x<eyes[0].x)
          //meta facia destra
          &&  (eyes[0].x<(faces[0].x+faces[0].width/2))
           && (faces[0].y<eyes[0].y)
           // meta in su
           && (eyes[0].y<(faces[0].y+faces[0].height/2)))
         {  
             text("dx",eyes[0].x, eyes[0].y); 
                 //disegno il singolo occhio  
             ellipse(eyes[0].x+eyes[0].width/2, eyes[0].y+eyes[0].height/2, eyes[0].width/2, eyes[0].height/2);
         
         }
           if((faces[0].x<eyes[0].x)
          //meta faccia destra
          &&  (eyes[0].x>(faces[0].x+faces[0].width/2))
           && (faces[0].y<eyes[0].y)
           // meta in su
           && (eyes[0].y<(faces[0].y+faces[0].height/2)))
           {
             text("sx",eyes[0].x, eyes[0].y);   
               //disegno il singolo occhio  
             ellipse(eyes[0].x+eyes[0].width/2, eyes[0].y+eyes[0].height/2, eyes[0].width/2, eyes[0].height/2);
        
         }
             
             
       }
    }
translate(video.width,0);
opencv.drawOpticalFlow();
popMatrix();  
}


void captureEvent(Capture c) {
  c.read();
}

