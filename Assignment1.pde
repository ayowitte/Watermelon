//allows the use of ControlP5
import controlP5.*;

ControlP5 cp5;

float border = 40 ;

int mode = 0;

void setup()
{
    size(1000,700);
    cp5 = new ControlP5(this);
    background(0);
    
    centX = width*0.5f;
    
    centY = height*0.5f;
    
    //call function load data
    loadData();

}

ArrayList<Graph1> graph1 = new ArrayList<Graph1>();

//loads in and displays the csv file
void loadData()
{
  String[] strings = loadStrings("sleepstudy.csv");
   
    for (int i = 0 ; i < strings.length ; i ++)
    {
      Graph1 temp1 = new Graph1(strings[i]);

      graph1.add(temp1);     
    }
   
}


void BarGraph()
{
  background(0);
  float max = Float.MIN_VALUE;
  
  for (Graph1 temp1:graph1)
  {
    if (temp1.hours > max)
    {
      max = temp1.hours;
    }
  }
  
  float gap = map(1, 0, 14, 0, width - border - border);//checking the width of each bar
   
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
  
  }
  
  for (int i = 0 ; i < 11 ; i ++)
  {
    float y = map(i, 0, 10, height - border,  border);
    line(border - (border * 0.1f), y, border, y);
    float hAxisLabel = map(i, 0, 10, 0, max);
        
    textAlign(RIGHT, CENTER);  
    text((int)hAxisLabel, border - ((border * 0.1f) * 2.0f), y);
  }
  
  if (mouseX > border && mouseX < (width - border))
  {
    textAlign(LEFT, BASELINE); 
    int i = (int) map(mouseX, border, width - border, 0, graph1.size());
    
    textSize(14);
    text("Hours: " + graph1.get(i).hours, mouseX - 80, mouseY - 20);
    text("Agegroup: " + graph1.get(i).agegroup, mouseX - 80, mouseY - 6);
  }
}

float centX, centY;

void PieChart()
{
  background(0);
  float max = Float.MIN_VALUE;
  
  for (Graph1 temp1:graph1)
  {
    if (temp1.hours > max)
    {
      max = temp1.hours;
    }
  }
  
  float sum = 0;//sum
  for(int i = 0; i < graph1.size(); i++)
  {
    Graph1 ex = null;
    ex = graph1.get(i);
    sum += ex.hours;
  }
 
  float thetaPrev = 0;//inital angle
  
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

    arc(centX, centY, 500,500, thetaPrev, thetaPrev + theta);//code for the segment
    thetaPrev += theta;
    
    fill(255);
    text(graph1.get(i).agegroup, x, y);
    
    } 
}

void draw()
{
  switch(mode)
  {
    case 1:
    {
      BarGraph();  
      break;
    }
    case 2:
    {
       PieChart();
       break; 
    }
    default:
    {
      
      break;
    }
  }//end switch
  
  
}

void keyPressed()
{
  if(key>='0' && key<='9')
  {
    mode = key - '0';
  }
}
