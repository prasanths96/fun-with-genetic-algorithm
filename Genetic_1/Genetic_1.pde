Population test;
Population newPopulation;
Population oldPopulation;
Obstacles[] obstacles;
Goal goal;
int populationsize = 1000;
double mutationRate = 0.3;
int frames = 400;
int risingTraining = 1;
int generation = 1;
int obstacleNumber = 5;
boolean run = false;


//________________________________
void setup(){
size (800,800);
goal = new Goal((int) width/2,(int) 25);

/// Creating obstacles ___________________
obstacles = new Obstacles[obstacleNumber];
for(int i =0; i<obstacleNumber; i++){
   obstacles[i] = new Obstacles(); 
}
  //obstacles[0] = new Obstacles(new PVector(0,height/1.5),600,20);
  //obstacles[1] = new Obstacles(new PVector(400,height/3),400,20);
////____________________________________

test = new Population(populationsize, goal, frames, obstacles);
oldPopulation = test;





}

//___________________________________

void draw(){
  if(run)
  {
  background(255);
  fill(0,0,255);
  ellipse(goal.pos.x,goal.pos.y,10,10);
  //rect(0 ,height/1.5,600,20);
  //rect(200 ,height/3,600,20);
  if(test.isAllDotsDeadOrWin()){
  
    // Genetic Algo
  test.calculateFitness();
  test.calculateProbFitness();
  newPopulation = test.generateNewPopulation();
  oldPopulation = test;
  test = newPopulation; 
  generation++;
 // if(generation%10 == 0){
    risingTraining ++;
  //}

  }else{
  textSize(20);
  fill(255,0,0);
  text("Generation : "+generation,10,40); 
  text("Best Fitness : "+oldPopulation.getBestFitness(),10,70);
  fill(0,0,255);
  text("<--Goal",width/2 + 20,32);
  fill(255,0,0);
  text("Start",width/2 - 20 ,height - 10);
  fill(0);
  text("Genetic Algorithm test by Pras",width/2 - 100,height/2);
  text("Computer learning by itself.. over Generations",width/2 - 170,height/2 + 30);
  test.update();
  test.show();
  for(int i = 0; i<obstacleNumber; i++){
  obstacles[i].show();
  }
  }

//________________________________________________________________

 }
}

void mouseClicked(){
 run =!run; 
}
