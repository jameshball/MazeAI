/* Stores all details of an obstacle in the maze. */
class Obstacle{
  /* 2D vectors determining the x, y position of the obstacle
     and the width/height of the obstacle. */
  PVector pos;
  PVector size;
  
  Obstacle(int posx, int posy, int sizex, int sizey) {
    pos = new PVector(posx, posy);
    size = new PVector(sizex, sizey);
  }
  
  /* Draws the obstacle to screen using pos and size. */
  void show() {
    fill(0, 0, 255);
    stroke(0, 0, 255);
    rect(pos.x, pos.y, size.x, size.y);
  }
}
