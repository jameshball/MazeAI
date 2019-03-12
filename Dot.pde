class Dot{
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  boolean hitWall = false;
  boolean hitMaze = false;
  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;
  
  float fitness = 0.0;
  
  Dot(){
    brain = new Brain(stepCount);
    
    pos = new PVector(mazeWidth - 10, mazeHeight - 10);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
  void show(){
    if(isBest){
      fill(0, 255, 0);
      stroke(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    }
    else {
      fill(0);
      stroke(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }
  
  void move(){
    if (brain.directions.length > brain.step){
      acc = brain.directions[brain.step];
      brain.step++;
    }
    else {
      dead = true;
      calculateFitness();
    }
    
    
    vel.add(acc);
    vel.limit(40);
    pos.add(vel);
  }
  
  void update(){
    if (!dead && !reachedGoal && !hitWall && !hitMaze){
      move();
      if (isCollidingWithWall()){
        hitWall = true;
        calculateFitness();
      }
      else if (isCollidingWithMaze()) {
        hitMaze = true;
        calculateFitness();
      }
      else if (dist(pos.x, pos.y, maze.goals.locations.get(maze.goals.currentGoal).x, maze.goals.locations.get(maze.goals.currentGoal).y) < 5) {
        reachedGoal = true;
        calculateFitness();
      }
    }
  }
  
  void calculateFitness(){
    if (fitness == 0) {
      float distanceToGoal = dist(pos.x, pos.y, maze.goals.locations.get(maze.goals.currentGoal).x, maze.goals.locations.get(maze.goals.currentGoal).y);
      
      if (dead || reachedGoal) {
        fitness = 1.0/(distanceToGoal * distanceToGoal + (int)Math.pow(brain.step, 2));
      }
      else {
        fitness = 0.00000000000000000000000000000001;
      }
    }
  }
  
  boolean isCollidingWithMaze() {
    for (int i = 0; i < maze.obs.size(); i++) {
      Obstacle currentOb = maze.obs.get(i);
      if (pos.x < (currentOb.pos.x + currentOb.size.x + 5) && pos.x > currentOb.pos.x + 5 && pos.y < (currentOb.pos.y + currentOb.size.y + 5) && pos.y > currentOb.pos.y + 5) {
        return true;
      }
    }
    
    return false;
  }
  
  boolean isCollidingWithWall() {
    if (pos.x < 2 || pos.y < 2 || pos.x > mazeWidth - 2 || pos.y > mazeHeight - 2) {
      return true;
    }
    
    return false;
  }
  
  Dot getBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();
    
    return baby;
  }
}
