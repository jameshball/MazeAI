class Maze {
  ArrayList<Obstacle> obs = new ArrayList<Obstacle>();
  Goals goals = new Goals();
  
  void show() {
    for (int i = 0; i < obs.size(); i++) {
      obs.get(i).show();
      fill(255, 0, 0);
      //textSize(20);
      //text(i + 1, obs.get(i).pos.x + 30, obs.get(i).pos.y - 10);
    }
    goals.show();
  }
}
