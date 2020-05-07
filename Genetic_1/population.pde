class Population{
  Dot[] dots;
  double sumFitness = 0;
  int size;
  Goal goal;
  int frames;
  double bestFitness = 0;
  int bestFitnessIndex = 0;
  Obstacles[] obstacles ;
  
  Population(int size, Goal goal, int frames, Obstacles[] obstacles){
    this.size = size;
    this.goal = goal;
    this.frames =frames;
    this.obstacles = obstacles;
    dots = new Dot[size];
    for(int i=0; i<size; i++){
      dots[i] = new Dot(goal,frames,obstacles);
    }
    
  }

//___________________________________________
void show(){
for(int i =0; i< dots.length; i++){
  dots[i].show();
}
}

//_____________________________________________

void update(){
  for(int i=0; i< dots.length; i++){
   dots[i].update(); 
  }
}
//_________________________________________________-

boolean isAllDotsDeadOrWin (){
  for (int i = 0; i < dots.length; i++)
  {
    if(!dots[i].dead){
      if(!dots[i].win)
      {
      return false; // false
      }
     }
  }
  return true;
}

//________________________________________________
void calculateFitness(){
  sumFitness = 0;
  for (int i=0; i < dots.length; i++){
     dots[i].calculateFitness();
     sumFitness = sumFitness + dots[i].fitness; 
     if(bestFitness < dots[i].fitness){
      bestFitness = dots[i].fitness; 
      bestFitnessIndex = i;
   }
  }
  
}
//___________________________________________________-
double getBestFitness(){
 return bestFitness; 
}

//_____________________________________________________
void calculateProbFitness(){
  for(int i = 0; i < dots.length; i++){
   dots[i].prob = dots[i].fitness / sumFitness; 
  }
  
}

//________________________________________________________

Population generateNewPopulation(){
 Population newPopulation = new Population(size, goal, frames, obstacles);
 Dot ParentDotA;
 Dot ParentDotB;
 Dot Child;
 for(int i=0; i<size-1; i++){
 ParentDotA = this.dots[pick()];
 ParentDotB = this.dots[pick()];
 Child = ParentDotA.crossOver(ParentDotB) ;
 //Mutation
 if(random(1)<mutationRate){
   int mutationSize =(int) (frames * 0.01);
   while((mutationSize--) > 0){
         Child.brain.directions[(int)random(frames)] = PVector.fromAngle(random(2*PI));
         //Child.brain.directions[frames - mutationSize] = PVector.fromAngle(random(2*PI));
   }
 }
 
 newPopulation.dots[i] = Child;
 
 }
 Child = new Dot(goal, frames, obstacles);
 Child.brain = this.dots[bestFitnessIndex].brain;
 Child.brain.step = 0;
 Child.green = true;
 newPopulation.dots[size-1] = Child;
 return newPopulation;
}

//__________________________________________________________________________________________________

int pick(){
 double r = random(1);
  int index = 0;
 // Picking parent index
  while( r > 0){
    if(index < this.dots.length){
       r = r - this.dots[index].prob;
       index ++;
    }else{
      index = 1;
    }
  }
  if(r == 0)
  {
    return 0;
  }
  index --;
  return index;
}

//____________________________________________________________________________________________________-
boolean fun(){
 return this.dots[0].dead; 
}

}
