//allows the use of ControlP5
import controlP5.*;
//allows the use of gifs
import gifAnimation.*;
//allows audio to be played
import ddf.minim.*;

ControlP5 cp5;

Gif loopingGif;

Minim m;
AudioPlayer song;

float border = 40 ;

//saves the users input(keypressed)
//set default to 1
int mode = 1;

void setup()
{
    size(1000,700);
    cp5 = new ControlP5(this);
    background(0);
    
    //controls the fps
    frameRate(100);
    //loads in the gif
    loopingGif  = new Gif(this, "Snoop dog.gif");
    
    m = new Minim(this);
    //loads song from the data folder
    song = m.loadFile("Drop It Like It's Hot.mp3");
    song.play();

    //sets the centre values
    centX = width*0.5f;
    centY = height*0.5f;
    
    //call function load data
    loadData();

}//end setup


//creates global arraylist
ArrayList<Graph1> graph1 = new ArrayList<Graph1>();

//loads in and displays the csv file
void loadData()
{
  String[] strings = loadStrings("sleepstudy.csv");
   
    for (int i = 0 ; i < strings.length ; i ++)
    {
      Graph1 temp1 = new Graph1(strings[i]);

      graph1.add(temp1);     
    }//end for
   
}//end loadData


//Bargraph function
void BarGraph()
{
  background(0);
  float max = Float.MIN_VALUE;
  
  for (Graph1 temp1:graph1)
  {
    if (temp1.hours > max)
    {
      max = temp1.hours;
    }//end if
  }//end for
  
  //checking the width of each bar
  float gap = map(1, 0, 14, 0, width - border - border);
   
  float scaleFactor = map(1, 0, max, 0, height - border - border);
  for (int i = 0 ; i < graph1.size() ; i ++)
  {
    Graph1 temp1 = graph1.get(i);
    stroke(temp1.colour);
    fill(temp1.colour);
    float x = i * gap;
    rect(x + border, height - border, gap, - (temp1.hours * scaleFactor));
    stroke(255);
    fill(255);
    
    line(border, border , border, height - border);
    line(border, height - border, width - border, height - border);
  
  }//end for
  
  for (int i = 0 ; i < 11 ; i ++)
  {
    float y = map(i, 0, 10, height - border,  border);
    line(border - (border * 0.1f), y, border, y);
    float hAxisLabel = map(i, 0, 10, 0, max);
        
    textAlign(RIGHT, CENTER);  
    text((int)hAxisLabel, border - ((border * 0.1f) * 2.0f), y);
    
  }//end for
  
  if (mouseX > border && mouseX < (width - border))
  {
    textAlign(LEFT, BASELINE); 
    int i = (int) map(mouseX, border, width - border, 0, graph1.size());
    
    textSize(14);
    text("Hours: " + graph1.get(i).hours, mouseX - 80, mouseY - 20);
    text("Agegroup: " + graph1.get(i).agegroup, mouseX - 80, mouseY - 6);
    
  }//end if
  
}//end BarGraph


float centX, centY;

//function for PieChart
void PieChart()
{
  //sets background to 0 everytime function is called
  background(0);
  //sets text size
  textSize(16);
  float max = Float.MIN_VALUE;
  
  for (Graph1 temp1:graph1)
  {
    if (temp1.hours > max)
    {
      max = temp1.hours;
    }//end if
  }//end for
  
  //sum
  float sum = 0;
  for(int i = 0; i < graph1.size(); i++)
  {
    Graph1 ex = null;
    ex = graph1.get(i);
    sum += ex.hours;
  }//end for
  
  //inital angle
  float thetaPrev = 0;
  
  for(int i = 0 ; i < graph1.size() ; i ++)
  {
    Graph1 temp1 = graph1.get(i);
    
    stroke(temp1.colour);
    fill(temp1.colour);
    
    Graph1 ex = null;
    ex = graph1.get(i);
       
    float theta = map(ex.hours, 0, sum, 0, TWO_PI);
    
    textAlign(CENTER);
    
    float radius = centX * 0.65f;
    float x = centX + sin(thetaPrev + (theta * 0.5f) + HALF_PI) * radius;      
    float y = centY - cos(thetaPrev + (theta * 0.5f) + HALF_PI) * radius;

    //code for the segment
    arc(centX, centY, 500,500, thetaPrev, thetaPrev + theta);
    thetaPrev += theta;
    
    fill(255);
    text(graph1.get(i).agegroup, x, y);
    
    }//end for
    
}//end PieChart


void draw()
{
  switch(mode)
  {
    case 1:
    {
      background(0);
      stroke(250);
      line(0, 350, 1000, 350);
      line(500, 0, 500, 700);
      
      //display text for menu
      textSize(32);
      text("Press 1 for Menu", 100, 200);
      text("Press 2 for BarGraph", 600, 200);
      text("Press 3 for PieChart", 50, 500);
      
      textSize(19);
      text("Press 4 to pause the Music",600, 380);
      text("Press 5 to resume the Music",600, 680);
      
      
      //plays gif in loop
      image (loopingGif, 500, 400);
      loopingGif.play();
        
      break;
    }//end case 1
    
    case 2:
    {
       //call BarGraph function
       BarGraph();
       
       break; 
    }//end case 2
    
    case 3:
    {
      //call PieChart function
       PieChart();
      
       break;
    }//end case 3
    
    case 4:
    {
      //pauses music
      song.pause();
      
      break;
    }//end case 4
    
    case 5:
    {
      //music resumes playing
      song.play();
      
      break;
     }//end case 5
    
    default:
    {
      background(0);
      textSize(25);
      
      //error correction
      text("Invalid Input!\n\n Press 1 to return to the Menu", 400, 300);
      
      break;
    }//end default
    
  }//end switch
  
}//end draw


//detects input from User
void keyPressed()
{
  if(key>='0' && key<='9')
  {
    mode = key - '0';
  }//end if
  
}//end keyPressed
