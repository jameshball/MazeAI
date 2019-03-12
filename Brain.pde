/* The Brain class contains all data relating to the movement of each dot. 
   The array of directions is what is passed from generation to generation. */
class Brain {
  PVector[] directions;
  /* The current step-count of the dot. A 'step' is simply one movement. i.e. an
     application of a force in the directions array. */
  int step = 0;

  /* Initialise the brain to random values. */
  Brain(int size){
    directions = new PVector[size];
    randomize();
  }
  
  /* Generates random vectors for the directions array. These are unit vectors (mag. 
     of 1) with a random angle. */
  void randomize(){
    for (int i = 0; i < directions.length; i++) {
      float randomAngle = random(2*PI);
      directions[i] = PVector.fromAngle(randomAngle);
    }
  }
  
  /* Returns a clone of the current brain, but with random vectors for any steps that
     haven't yet been made. The new random steps causes the 'explosion' effect you see
     when the dots reach last generation's stepCount. */
  Brain clone(){
    Brain clone = new Brain(stepCount);
    for(int i = 0; i < stepCount; i++){
      if (i < directions.length) {
        clone.directions[i] = directions[i].copy(); 
      }
      else {
        float randomAngle = random(2*PI);
        clone.directions[i] = PVector.fromAngle(randomAngle);
      }
    }
    
    return clone;
  }
  
  /* Randomly changes 0.1% of the direction vectors in the current brain. */
  void mutate(){
    float mutationRate = 0.001;
    
    for(int i = 0; i < directions.length - 1; i++){
      float rnd = random(1);
      
      if (rnd < mutationRate) {
        float randomAngle = random(2*PI);
        directions[i] = PVector.fromAngle(randomAngle);
      }
    }
  }
}
