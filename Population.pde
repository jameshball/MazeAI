class Population{
  Dot[] dots;
  float fitnessSum;
  int bestDot;
  
  Population(int size) {
    dots = new Dot[size];
    
    for(int i = 0; i < size; i++){
      dots[i] = new Dot();    
    }
  }
  
  void show(){
    for(int i = 0; i < dots.length; i++){
      dots[i].show();
    }
  }
  
  void update(){
    for(int i = 0; i < dots.length; i++){
      dots[i].update();
    }
  }
  
  boolean allDotsDead(){
    for(int i = 0; i < dots.length; i++){
      if (!dots[i].dead && !dots[i].reachedGoal && !dots[i].hitWall && !dots[i].hitMaze) {
        return false;
      }
    }
    
    return true;
  }
  
  void naturalSelection(){
    Dot[] newDots = new Dot[dots.length];
    calculateFitnessSum();
    
    bestDot();
    
    newDots[newDots.length - 1] = dots[bestDot].getBaby();
    newDots[newDots.length - 1].isBest = true;
    for(int i = 0; i < newDots.length - 1; i++){
      Dot parent = selectParent();
      
      newDots[i] = parent.getBaby();
    }
    
    dots = newDots.clone();
    gen++;
    stepCount = stepCount + 20;
    if (stepCount > 2500) {
      stepCount = 2500;
    }
  }
  
  void calculateFitnessSum(){
    fitnessSum = 0;
    
    for(int i = 0; i < dots.length; i++){
      fitnessSum += dots[i].fitness;
    }
  }
  
  Dot selectParent() {
    float rnd = random(fitnessSum);
    
    float runningSum = 0;
    
    for(int i = 0; i < dots.length; i++){
      runningSum += dots[i].fitness;
      
      if(runningSum > rnd) {
        return dots[i];
      }
    }
    
    return null;
  }
  
  void mutate(){
    for(int i = 0; i < dots.length; i++){
      if (!dots[i].isBest){
        dots[i].brain.mutate();
      }
    }
  }
  
  void bestDot(){
    float max = 0;
    bestDot = 0;
    for(int i = 0; i < dots.length; i++){
      if(dots[i].fitness > max) {
        max = dots[i].fitness;
        bestDot = i;
      }
    }
  }
  
  int goalReachTotal() {
    int goalReachTotal = 0;
    
    for(int i = 0; i < dots.length; i++){
      if (dots[i].reachedGoal){
        goalReachTotal++;
      }
    }
    
    return goalReachTotal;
  }
  
  void processGraphs() {
    Datapoint min = new Datapoint(true);
    Datapoint max = new Datapoint(true);
    Float total = 0.0;
    
    for(int i = 0; i < dots.length; i++){
      if (dots[i].reachedGoal){
        if (min.isEmpty) {
          min.data = (float)dots[i].brain.step;
          min.isEmpty = false;
        }
        else if (dots[i].brain.step < min.data) {
          min.data = (float)dots[i].brain.step;
        }
      }
      
      if (max.isEmpty) {
        max.data = dots[i].fitness;
        max.isEmpty = false;
      }
      else if (dots[i].fitness > max.data) {
        max.data = dots[i].fitness;
      }
      
      total += dots[i].fitness;
    }
    
    avgFitness.add(new Datapoint((total)/dots.length, false));
    
    fewestSteps.add(min);
    
    maxFitness.add(max);
    
    //System.out.println((total)/dots.length);
  }
  
  void nextGoal() {
    if (goalReachTotal() > 50 && maze.goals.currentGoal + 1 < maze.goals.locations.size()) {
      maze.goals.currentGoal++;
    }
  }
}
