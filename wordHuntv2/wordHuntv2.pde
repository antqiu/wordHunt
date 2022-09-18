//final 
static final float textScaleFactor=.5;
PFont font, bold;
PImage rules, paper;
Box b;
Game g;
int mode;
String[] validWords;
IntDict StartIndex;

void setup() {
  size(600, 700);
  font=createFont("Font.otf", 20);
  bold=createFont("BoldFont.otf", 20);
  //rules=loadImage("Instructions.jpg");
  rules=loadImage("InstructionsV2.png");
  paper=loadImage("paper.png");
  validWords=loadStrings("all.txt");
  
  background(113, 159, 112);
  StartIndex = new IntDict();
  indexChange();
  mode=0; //0=nothing, 1=Game, 2=EndScreen
  intro();
} //setup

void draw() {
  if (mode==0) return;
  background(113, 159, 112);
  if (mode==2) {
    endScreen();
    return;
  }
  g.displayGrid();
  displayGuess();
  if (int(g.timer.time)<=0) mode=2;
} //draw

void mousePressed() {
  if (mode==0) {
    g=new Game();
    mode=1;
  }
  if (mode==2) {
    delay(1000); 
    reset();
    mode=1;
  }
} //mousePressed

void mouseDragged() {
  if (mode==1) {
    for (int i=0; i<16; i++) {
      //check if mouse is inside a box
      if (g.grid[i].inside(mouseX, mouseY) && g.grid[i].selected==false) {
        if (g.list.start==null || g.list.back==null || dist(g.grid[i].x, g.grid[i].y, g.list.back.x, g.list.back.y) < 115*sqrt(2)+20) {
        g.grid[i].selected=true;

        //adds to guess word
        g.guessWord+=g.grid[i].letter;

        //appends the box to boxlist
        g.list.append(g.grid[i]);
        
        //correctness based color
        if (g.guessWord.length() < 3 || validWord(g.guessWord)==false) {
          for (int p=0; p<16; p++) {
            g.grid[p].boxFill=color(246, 243, 244);
            g.grid[p].strokeFill=color(186,84,63);
          }
          if (alreadyGuessed(g.guessWord)) {
            for (int z=0; z<16; z++) {
              g.grid[z].boxFill=color(235, 139, 49);
              g.grid[z].strokeFill=color(255);
            }
          }
        }
        //colors all the currently selected boxes
        else {
          for (int q=0; q<16; q++) {
            if (g.grid[q].selected) g.grid[q].boxFill=color(157, 254, 148);
             g.grid[q].strokeFill=color(255);
          }
        }
      }
      } //if selected
      //has to be neighboring
    } //for
  } //if
} //mouseDragged

boolean alreadyGuessed(String guess) {
  for (int q=0; q<g.guessedWords.size(); q++) {
    if (guess.equals(g.guessedWords.get(q))) return true;
  }
  return false;
} //alreadyGuessed

void indexChange() {
  //HashMap<String,Integer> StartIndex = new HashMap<String,Integer>();
  String startChar="A";
  StartIndex.set("A", 0);
  
  for (int i=0; i<validWords.length; i++) {
    if (validWords[i].substring(0,1).equals(startChar)) continue;
    startChar=validWords[i].substring(0,1);
    StartIndex.set(startChar, i);
  }
  //println(StartIndex);
  //println(validWords[2074]);
  //println(validWords[2075]);
} //indexChange

boolean validWord(String guess) {
  int len=guess.length();
  if (len < 3) return false;
  //check if alreadyGuessed
  for (int q=0; q<g.guessedWords.size(); q++) {
    if (guess.equals(g.guessedWords.get(q))) return false;
  }
  //check if guess is in the text file
  if (guess.charAt(0)=='Z') {
   for (int i=StartIndex.get(guess.substring(0,1)); i<validWords.length; i++) {
    if (guess.equals(validWords[i])) return true; 
   }
  } //from a-y
  else {
    for (int i=StartIndex.get(guess.substring(0,1)); i<StartIndex.get(str(char(byte(1+byte(guess.substring(0,1).charAt(0)))))); i++) {
    if (guess.equals(validWords[i])) return true;
  }
  }
  //if eight letters or higher
  return false;
} //validWord

void mouseReleased() {
  if (mode==1) {
    //points handling and adds to stringlist
    int len=g.guessWord.length();
    if (len >=3 && validWord(g.guessWord)) {
      g.score += decideScore(g.guessWord);
      g.guessedWords.append(g.guessWord);
    }

    g.list.reset();
    //deselect
    for (int i=0; i<16; i++) {
      g.grid[i].next=null;
      g.grid[i].selected=false;
      g.guessWord="";
      g.grid[i].strokeFill=color(186,84,63);
    }
  } //if
} //mouseReleased

void endScreen() {
  fill(255);
  //rect(125, height/4-35, width-250, height/2+175, 15);
  //rect(125, height/4-115, width-250, 70, 15);
  image(paper,width/2-15,height/2, height/2+150, height-50);
  fill(0);
  textFont(bold);
  textSize(15*textScaleFactor);
  textAlign(LEFT);
  text("WORDS: " +g.guessedWords.size(), 145, height/4-85);
  text("SCORE: " +g.score, 145, height/4-60);
  textAlign(CENTER);
  textFont(bold);
  textSize(12*textScaleFactor);
  fill(255);
  text("Click Anywhere To Restart", width/2, 35);
  fill(0);
  textAlign(CORNER);
  //listing out words
  int len=g.guessedWords.size();
  int position=165;
  textAlign(LEFT);
  textFont(bold);
  textSize(12*textScaleFactor);
  for (int q=0; q<len; q++) {
    String pts="";
    if (g.guessedWords.get(q).length() == 3) pts+="100";
    else if (g.guessedWords.get(q).length() == 4) pts+="400";
    else if (g.guessedWords.get(q).length() == 5) pts+="800";
    else if (g.guessedWords.get(q).length() == 6) pts+="1400";
    else if (g.guessedWords.get(q).length() == 7) pts+="2200";
    text(g.guessedWords.get(q)+" (+ "+pts+")", 145, position);
    //position+=525/(len+1);
    position+=18;
  }
  textFont(bold);
} //endScreen

void intro() {
  fill(255);
  noStroke();
  rectMode(CENTER);
  rect(width/2, height/2, 425, 425, 15);
  rectMode(CORNER);
  fill(0);
  textSize(20*textScaleFactor);
  textAlign(CENTER);
  textFont(bold);
  text("How to Play:", width/2, height/4+17);
  textFont(font);
  textSize(15*textScaleFactor);
  text("Connect letters together by dragging the mouse. \n Make as many words as you can.", width/2, height/4+50);
  imageMode(CENTER);
  image(rules, width/2, height/2+30, 200, 200);
  fill(125);
  text("Click anywhere to start", width/2, height/2+height/4);
  fill(0);
} //intro

void reset() {
  g=new Game();
} //reset

void keyPressed() {
 if (key=='r') {
  reset(); 
 }
} //keyPressed

int decideScore(String word) {
  int len=word.length();
    if (len == 3) return 100;
    if (len == 4) return 400;
    if (len ==5) return 800;
    if (len == 6) return 1400;
    if (len == 7) return 2200; 
    return 0;
} //decideScore

void displayGuess() {
  if (g.guessWord.equals("")) return;
  fill(255);
  rectMode(CENTER);
  rect(width/2, 200-35-25, 250, 50, 10);
  textAlign(CENTER);
  fill(0);
  textSize(18*textScaleFactor);
  if (validWord(g.guessWord)) {
    int score=decideScore(g.guessWord);
    text(g.guessWord + " (+" + score + ")", width/2, 207-35-25);
  }
  else text(g.guessWord, width/2, 207-35-25);
  rectMode(CORNER);
} //displayGuess
