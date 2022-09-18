class Timer {
 int elapsedTime;
 int duration;
 int time;
 
 Timer(int t) {
  elapsedTime=millis();
  time=t;
  duration=t;
 } //time
 
 void updateTimer() {
   if (time>0) time=duration-(millis()-elapsedTime)/1000; 
   fill(255);
   if (time<=5) fill(255,0,0);
   textSize(25*textScaleFactor);
   textAlign(RIGHT);
   text(time, width-20, 50);
 } //updateTimer
}
