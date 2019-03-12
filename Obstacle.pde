class Obstacle{
  PVector pos;
  PVector size;
  
  Obstacle(int posx, int posy, int sizex, int sizey) {
    pos = new PVector(posx, posy);
    size = new PVector(sizex, sizey);
  }
  
  Obstacle() {
    pos = new PVector(-100, -100);
    size = new PVector(0, 0);
  }
  
  void show() {
    fill(0, 0, 255);
    stroke(0, 0, 255);
    rect(pos.x, pos.y, size.x, size.y);
  }
}
