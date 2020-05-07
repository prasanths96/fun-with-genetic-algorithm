class Dot{
 PVector pos;
 PVector vel;
 PVector acc;
 Brain brain;
 boolean dead = false;
 boolean win = false;
 Goal goal;
 double fitness;
 double prob;
 int frames;
 Obstacles[] obstacles;
 boolean green = false;
 int ellipseSize = 4;
 
 Dot(Goal goal, int frames, Obstacles[] obstacles){
    brain = new Brain(frames);
    this.obstacles = obstacles; 
    pos = new PVector(width/2,height-10);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    this.goal = goal;
    this.frames = frames;
 }
 
 //________________________________________________
 
 void show(){
   fill(0);
   if(green == true){
    fill(0,255,0); 
    ellipseSize = 10;
   }
   ellipse(pos.x,pos.y,ellipseSize,ellipseSize);
 }

//________________________________________________

void move(){
 if(brain.directions.length > brain.step ){    /// modified here   && risingTraining > brain.step
  acc = brain.directions[brain.step];
  brain.step++;
 }else{
   dead = true;
 }
 if(!dead && !win){
  vel.add(acc);
  vel.limit(5);
  pos.add(vel);
 }
}

//-----------------------------------------------------

void update(){
 if(!dead && !win){
  if(pos.x < 2 || pos.y < 2 || pos.x > width - 2 || pos.y > height -2){
    dead = true;
  }
  if(pos.dist(goal.pos)<=5){
    win = true;
  }
  for(int i=0; i<obstacles.length; i++){
    if((this.pos.x >= obstacles[i].pos.x - 2)&&(this.pos.x <= (obstacles[i].pos.x + obstacles[i].obstacleWidth + 2) )&&(this.pos.y > obstacles[i].pos.y - 2)&&(this.pos.y < (obstacles[i].pos.y + obstacles[i].obstacleHeight + 2))){
      dead =true;
      break;
    }
  }
  move();
 }
}

//_______________________________________________________________-

void calculateFitness(){
  double modifier = 1;
  double modifier2 = 1;
  int multiplier = 1;
  //
 /*
  for(int i=0; i< brain.step-1; i++){
     if(brain.directions[i] == brain.directions[i+1]){
         modifier2 = modifier2 + (0.01 * multiplier);
         multiplier ++;
     }else{
       multiplier = 1;
     }
  }
  */
  //
  
  if(win == true){
    //modifier = frames / (brain.step)  ;
    modifier = 10 * frames/brain.step ;
  }
  if(dead == true){
    //modifier = 0.01 * brain.step;
    modifier = 0.1 * brain.step / frames;
  }
  double mainvalue = 1/(goal.pos.dist(pos) * goal.pos.dist(pos) * goal.pos.dist(pos));
  fitness = mainvalue * modifier * modifier2;
  //fitness = (1/brain.step) * mainvalue;
}

//________________________________________________________________

Dot crossOver(Dot B){
 int midpoint = (int) (random(frames));
 Dot child = new Dot(goal, frames, obstacles);
 for(int i=0; i<midpoint; i++){
   child.brain.directions[i] = this.brain.directions[i];
 }
 for(int i=midpoint; i<frames; i++){
   child.brain.directions[i] = B.brain.directions[i]; // B
  }
 
 return child;
}

}
