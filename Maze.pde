/* Stores all obstacles and goals in the maze. */
class Maze {
  ArrayList<Obstacle> obs = new ArrayList<Obstacle>();
  Goals goals = new Goals();
  
  /* Shows all obstacles and goals in the maze. */
  void show() {
    for (int i = 0; i < obs.size(); i++) {
      obs.get(i).show();
      fill(255, 0, 0);
    }
    goals.show();
  }
}
