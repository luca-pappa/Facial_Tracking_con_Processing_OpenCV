/* Codice per lezione 1 :

                          schetck di prova nel quale verranno riconosciuti e contati 
                          visi di persone che si avvicinano frontalmente alla camera
                          esponendo a schermo una stringa con il contatore 
                          Luca Rosario Pappa 10-10-2015
*/

//importazione libreria opencv
import gab.opencv.*;

//importazione libreria video
import processing.video.*;


//importazione libreria java AWT per la gestione delle forme geometriche
import java.awt.*;

//dichiarazione oggetto Capture che gestira' la camera
Capture video;

//dichiarazione oggetto OpenCV a cui daremo in input i fotogrammi della camera
OpenCV opencv;

//contatore che utilizzerermo per tener traccia di quanti visi vengono riconosciuti ogni fotogramma 
int faceCounter;

//Scegliamo la risoluzione della nostra finestra

//Scegliamo la larghezza della nostra finestra
int screenWidth=640;

//Scegliamo l'altezza della nostra finestra
int screenHeight=480;

//funzione che verra' eseguita una sola volta, utilizzata per configurazioni iniziali
void setup() 
{

//impostiamo la risoluzione dello schermo
  size(screenWidth, screenHeight);

//creazione oggetto Capture per la gestione della camera
//i parametri del costruttore dell'oggetto Capture ci impongono di indicare a quale PApplet si fa riferimento
//inoltre indichiamo la risoluzione dello schermo scelta
  video = new Capture(this, screenWidth, screenHeight);

//i parametri del costruttore dell'oggetto OpenCV ci impongono di indicare a quale PApplet si fa riferimento
//inoltre indichiamo la risoluzione dello schermo scelta come sopra
  opencv = new OpenCV(this, screenWidth, screenHeight);

//contatore visi riconosciuti per ogni fotogramma questa variabile verra' aggiornata ogni fotogramma
  faceCounter=0;


/* 
   loadCascade e' una delle funzioni principali di tutta la lezione, grazie ad essa riusciamo a riconoscere 
   un viso in un fotogramma, ma come? come fare a combinare un algoritmo robusto (pochi falsi positivi) e 
   uno efficiente ( in velocita')?
   I cassificatori cascade sono il frutto di apprendimento su centinaia di foto di visi (in posizione 
   frontale nel nostro esempio). Sono rappresentati come file xml che descrivono aree di riconoscimento 
   (ma per andare più nel dettaglio dovremmo aspettare la lezione 2, :-o ).
   Per oggi ci basta sapere che sono uno strumeto efficace ed efficiente per il riconoscimento facciale.
   Saremo ripetitivi ma ricordiamo che ogni fotogramma deve essere analizzato dal classificatore e una webcam
   di un portatile invia al processore anche 30 fotogrammi al secondo. 
*/
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
 

//accendi la camera
  video.start();

}

//la funzione draw viene chiama per ogni frame finche' non viene chaiamata la funzione noLoop();
void draw() 
{

//filter(GRAY);
 
//carichiamo ogni frame della camera nell'oggetto opencv
  opencv.loadImage(video);

//la fuzione image visualizza a video l'immagine passata come primo parametro, 
//il secondo e il terzo sono le coordinate a cui viene visualizzata
  image(video, 0, 0 );

//con la funzione noFill si impone ai poligoni creati di essere trasparenti quindi senza colore di riempimento 
  noFill();
//con la funzione stroke scegliamo il colore dei poligoni o linee o punti creati inserendo i valori in RGB 
// o in scala di grigi inserendo un solo valore ad es. stroke(123);
  stroke(0, 255, 0);

//la funzione strokeWeight ci fa scegliere lo spessore delle linee
  strokeWeight(1);
 
// la funzione detect restituisce tanti rettangoli quante sono sono i visi riconosciuti
  Rectangle[] faces = opencv.detect();
  
//associamo il contatore al numero di elementi dell'array di rettangoli che rappresentano i visi
  faceCounter=faces.length;
  
/* 
  grazie alla funzione text passando come primo parametro la stringa da visualizzare a schermo 
  e come secondo e terzo le coordinate x,y alle quali il testo verra' visualizzato, nel nostro
  casoil contatore di visi a (100,100)
*/
  text("face count:"+faceCounter,100,100);
  
  // ciclo foreach: per ogni Rettangolo (che chiamiamo face) nell'array faces   
   for(Rectangle face: faces )
     {
// stampa alle coordinate del viso trovato le stesse
       text(face.x +" " +face.y,face.x, face.y);
/*
  con la funzione rect creiamo un rettangolo alle coordinate che diamo nel primo e secondo parametro
  il terzo e il quarto ci daranno la larghezza e l'altezza rispettivamente, nel nostro caso quelle 
  del viso riconosciuto.
*/
       rect(face.x, face.y, face.width, face.height);
     }

}

//questa fuzione viene chiamato per ogni evento generato dall'oggetto Capture e
//nel nostro caso fa in modo che la camera continui a riptrendere ogni fotogramma

void captureEvent(Capture c) 
{
  c.read();
}

