//new class
class Graph1
{
  //values
  String agegroup;
  float hours;
  color colour;
  
  //determines how the info. is split
  Graph1(String lines)
  {
    String[] parts = lines.split(",");
    agegroup = parts[0];
    hours = Float.parseFloat(parts[1]);
    
    //sets colour to random everytime program is started
    colour = color(random(0,255),random(1,255),random(0,255));
    
  }//end Graph1
  
}//end class Graph1

