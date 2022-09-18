class Box {
  char letter;
  int x,y, size;
  color boxFill, textFill, strokeFill;
  boolean selected;
  //int[] letters = {65, 65, 65, 67, 68, 69, 69, 69, 70, 71, 72, 73, 73, 73, 74, 75, 76, 77, 78, 79, 79, 79, 80, 81, 82, 83, 84, 85, 85, 85, 86, 87, 88, 89, 89, 90}; 
  //vowels: 65 (a), 69 (e), 73 (i), 79 (o), 85 (u), 89 (y)
  int[] letters={65, 69, 73, 79, 85, 89};
  //ASCII table vowels but vowels have slightly higher probablity of getting picked
  
  Box next;
  
  Box(int xt, int yt) {
    x=xt;
    y=yt;
    //method 1
    //letter=char(byte(int(random(1)*(90-65+1)+65)));
    //method 2
    //letter=char(byte(letters[int(random(1)*letters.length)]));
    //method 3 
    if (random(1)<=.175) letter=char(byte(letters[int(random(1)*6)]));
    else letter=char(byte(int(random(1)*(90-65+1)+65)));
    
    boxFill=color(248,199,126);
    textFill=color(0);
    strokeFill=color(186,84,63);
    size=100;
    selected=false;
    
    next=null;
  } //Box constructor
  
  void display() {
    stroke(0);
    fill(boxFill);
    
    //if (selected) fill(157,254,148); //green
    if (!selected) fill(248,199,126); //brown
    
    //strokeWeight(1);
    noStroke();
    rect(x,y,size,size, 15);
    fill(textFill);
    textSize(30);
    textAlign(CENTER);
    text(letter, x+size/2, y+size/2+20);
    noStroke();
    
    // if (next!=null) {
    //   strokeWeight(10);
    //   stroke(strokeFill); 
    //   line(x+size/2, y+size/2, next.x+size/2, next.y+size/2);
    //   strokeWeight(1);
    //   stroke(255);
    //   //noStroke();
    //} //if
  } //display
  
  void displayLines() {
      if (next!=null) {
     strokeWeight(10);
     stroke(strokeFill); 
     line(x+size/2, y+size/2, next.x+size/2, next.y+size/2);
     strokeWeight(1);
     stroke(255);
     //noStroke();
  } //if 
  }
  

  boolean inside(int mousex, int mousey) {
    if (mousex > x && mousex < x+size && mousey > y && mousey < y+size) return true;
    else return false;
  }
}
