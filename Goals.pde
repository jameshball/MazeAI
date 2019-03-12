/* Stores the locations of all goals. */
class Goals{
  ArrayList<PVector> locations = new ArrayList<PVector>();
  int currentGoal = 0;
  
  void show() {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    ellipse(locations.get(currentGoal).x, locations.get(currentGoal).y, 10, 10);
  }
}
