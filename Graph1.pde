class Graph1
{
  String agegroup;
  float hours;
  color colour;
  
  Graph1(String lines)
  {
    String[] parts = lines.split(",");
    agegroup = parts[0];
    hours = Float.parseFloat(parts[1]);
    colour = color(random(0,255),random(1,255),random(0,255));
  }
}

