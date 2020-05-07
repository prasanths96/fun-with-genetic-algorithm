class Obstacles{
 PVector pos;
 int obstacleWidth;
 int obstacleHeight;
   
Obstacles(){
  pos = new PVector(random(width),random(height));
  //pos.x = 100;
  //pos.y = 100;
  obstacleWidth =  (int) random(300);
  obstacleHeight = (int) random(300);
}
Obstacles(PVector pos, int obstacleWidth, int obstacleHeight){
  this.pos = pos ;
  this.obstacleWidth =  obstacleWidth;
  this.obstacleHeight = obstacleHeight;
}
//______________________________________________
void show(){
 fill(255,0,0);
 rect(pos.x,pos.y,obstacleWidth,obstacleHeight);
}


}
