class Game {
  Box[] grid;
  int score;
  String guessWord;
  StringList guessedWords;
  Timer timer;
  BoxList list;
  
  Game() {
   grid=new Box[16];
   makeGrid();
   guessWord="";
   score=0;
   guessedWords=new StringList(); 
   timer=new Timer(90); //CHANGE TIME HERE, MEASURED IN SECONDS
   list=new BoxList(); 
  } //Game
  
  void makeGrid() {
    textFont(font);
    int startX=100-20;
    int startY=250-20-20;
    int offset=15;
    for (int row=0; row<4; row++) {
      for (int col=0; col<4; col++) {
        grid[row*4+col]=new Box(startX + col*100 + col*offset, startY + row*100 + row*offset); 
      }
    }
  } //makeGrid
  
  void displayGrid() {
   fill(69,95,70);
   stroke(142,232,137);
   strokeWeight(3.5);
   rect(80-20, 210-20, 484, 484, 20);
   for (int i=0; i<grid.length; i++) {
    grid[i].display(); 
   }
   for (int i=0; i<grid.length; i++) {
      grid[i].displayLines(); 
   }
   makeScore();
   timer.updateTimer();
  } //displayGrid
  
  void makeScore() {
   fill(255);
   rectMode(CORNER);
   //rect(width/4,0,width/2,90, 15);
   image(paper, width/2-15, 0, width/2+25, 203);
   fill(0);
   textSize(35*textScaleFactor);
   text("Score: " +score, width/2, 40);
   textSize(20*textScaleFactor);
   fill(50);
   text("Guessed words: "+guessedWords.size(), width/2, 70);
  } //makeScore
  
}
