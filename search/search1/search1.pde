
int[] data;
Node temp;
Node[] vertexList;
int NumberofVertex;
int height = 640;
int width = 360;


void setup() {
  size(640, 360);
  String[] stuff = loadStrings("data.txt");
    NumberofVertex = stuff.length;
  vertexList  = new Node[NumberofVertex];
  for(int i =0; i < stuff.length; i++){
      data = int(split(stuff[i],','));
      temp = new Node (data);
      vertexList[i] = temp;
  }

}



void draw() {
  background(255);
  for(int i = 0 ; i< vertexList.length ; i++){
    vertexList[i].draw();
}
  for(int i = 0 ; i< vertexList.length ; i++){
    vertexList[i].draw_edges();

}

}




class Node{
  boolean visited;
  color c;
  int index;
  float x;
  float y;
  int[] adjs;
  
  Node(int[] raw){
       adjs = new int[raw.length-1];
      for(int i = 0 ; i< raw.length; i++){
      if(i == 0 )
        index = raw[0];
        else
        adjs[i-1] = raw[i];
      }
      float degree = (index *360) / NumberofVertex;
      float h = ( ( degree*2*3.14)/ 360);
      x=   80*cos(h)+(height/2);
      y= 80*sin(h)+(width/2);
  }
  
  void draw(){
      fill(50, 0, 153);
  ellipse(x, y, 30, 30);
  fill(0,0, 153);
text(""+ index, x, y);

}

void draw_edges(){
  
for(int i = 0 ; i < adjs.length ; i++){
  float[] dst = vertexList[adjs[i]].get_coord();
    fill(100,0, 0);
  line(x, y, dst[0], dst[1]);
}

  }
  
  int[] get_adjs(){
    return adjs;
  }
  
  int get_Index(){
  return index;
  }
  

  float[] get_coord(){
    float[] ret = {x,y} ;
    return ret;
  }
  
  void print_node(){
  println(" index: " + index + "  friends: " + adjs);
  }
}