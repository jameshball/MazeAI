/* This stores all information about a dot, including its position, velocity,
   acceleration and whether it has died. */
class Dot{
  /* 2D vectors holding the position, velocity and acceleration of the dot. */
  PVector pos;
  PVector vel;
  PVector acc;
  
  Brain brain;
  
  /* Defines the metric by which the dot died. */
  boolean hitWall = false;
  boolean hitMaze = false;
  
  /* Self-explanatory booleans. i.e. true if the dot has died etc. */
  boolean dead = false;
  boolean reachedGoal = false;
  /* If this dot is a clone of the best dot from the last generation, this 
     boolean is true. */
  boolean isBest = false;
  
  /* Stores the fitness of the dot. */
  float fitness = 0.0;
  
  Dot(){
    brain = new Brain(stepCount);
    
    /* Initialise the dot to a random position on the grid. */
    pos = new PVector(mazeWidth - 10, mazeHeight - 10);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
  /* Shows the dot with a different colour if it is a clone of last 
     generation's best. */
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
  
  /* This class updates the acceleration, velocity and position of the dot. */
  void move(){
    /* If the dot still has more moves to make... */
    if (brain.directions.length > brain.step){
      /* Add the vector in the current step of the brain direction array to the 
         acceleration. */
      acc = brain.directions[brain.step];
      brain.step++;
    }
    /* If the dot has run out of moves, it is declared dead and its fitness is
       calculated. */
    else {
      dead = true;
      calculateFitness();
    }
    
    /* Add the acceleration to velocity, but limit the velocity to 40. */
    vel.add(acc);
    vel.limit(40);
    /* Update the position of the dot. */
    pos.add(vel);
  }
  
  /* Moves the dot and checks if the dot has hit a wall etc. If so, it is killed.
     Also checks to see if it has reached the goal. */
  void update(){
    /* Only update if the dot is still moving. */
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
      /* This checks to see if the dot has reached the goal. */
      else if (dist(pos.x, pos.y, maze.goals.locations.get(maze.goals.currentGoal).x, maze.goals.locations.get(maze.goals.currentGoal).y) < 5) {
        reachedGoal = true;
        calculateFitness();
      }
    }
  }
  
  /* This is the fitness function for this algorithm. It uses the distance to the goal,
     along with the speed at which it reached the goal. */
  void calculateFitness(){
    if (fitness == 0) {
      float distanceToGoal = dist(pos.x, pos.y, maze.goals.locations.get(maze.goals.currentGoal).x, maze.goals.locations.get(maze.goals.currentGoal).y);
      
      /* If the dot has just run out of steps to make, or it has actually reached the goal then calculate the fitness. */
      if (dead || reachedGoal) {
        fitness = 1.0/(distanceToGoal * distanceToGoal + (int)Math.pow(brain.step, 2));
      }
      /* If the dot has hit a wall or obstacle, then its fitness is calculated as a number
         effectively 0 in size. I can't remember why I didn't use fitness = 0, but there was
         a good reason for me to make it an unrealistically small number instead. */
      else {
        fitness = 0.00000000000000000000000000000001;
      }
    }
  }
  
  /* Checks to see if the dot lies within the boundaries of any obstacles in the maze. */
  boolean isCollidingWithMaze() {
    /* Iterates through all obstacles in the maze. */
    for (int i = 0; i < maze.obs.size(); i++) {
      Obstacle currentOb = maze.obs.get(i);
      /* If the dot lies within this obstacle... */
      if (pos.x < (currentOb.pos.x + currentOb.size.x + 5) && pos.x > currentOb.pos.x + 5 && pos.y < (currentOb.pos.y + currentOb.size.y + 5) && pos.y > currentOb.pos.y + 5) {
        return true;
      }
    }
    
    return false;
  }
  
  /* Checks to see if the dot lies within the boundaries of the maze or not. */
  boolean isCollidingWithWall() {
    if (pos.x < 2 || pos.y < 2 || pos.x > mazeWidth - 2 || pos.y > mazeHeight - 2) {
      return true;
    }
    
    return false;
  }
  
  /* Returns a clone of the current dot. */
  Dot getBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();
    
    return baby;
  }
}
