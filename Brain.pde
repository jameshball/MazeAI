class Brain {
  PVector[] directions;
  int step = 0;

  Brain(int size){
    directions = new PVector[size];
    randomize();
  }

  void randomize(){
    for (int i = 0; i < directions.length; i++) {
      float randomAngle = random(2*PI);
      directions[i] = PVector.fromAngle(randomAngle);
    }
  }
  
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
