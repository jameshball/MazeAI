import java.math.*;

Population population;
Maze maze;
Graph stepGraph;
Graph fitnessGraph;
int gen = 0;
int stepCount = 60;
ArrayList<Datapoint> fewestSteps = new ArrayList<Datapoint>();
ArrayList<Datapoint> maxFitness = new ArrayList<Datapoint>();
ArrayList<Datapoint> avgFitness = new ArrayList<Datapoint>();
int mazeWidth = 800;
int mazeHeight = 800;

void setup() {
  size(1600, 800, P2D);
  frameRate(144);
  smooth();
  population = new Population(2000);
  maze = new Maze();
  stepGraph = new Graph(900, 90, "Generation", "Step Count" , 670, 275, 4);
  fitnessGraph = new Graph(900, 470, "Generation", "Fitness" , 670, 275, 4);
  maze.goals.locations.add(new PVector(40, 600));
  maze.obs.add(new Obstacle(685, 400, 30, 100));
  maze.obs.add(new Obstacle(600, 585, 100, 30));
  maze.obs.add(new Obstacle(200, 185, 100, 30));
  maze.obs.add(new Obstacle(500, 485, 200, 30));
  maze.obs.add(new Obstacle(300, 385, 200, 30));
  maze.obs.add(new Obstacle(200, 485, 200, 30));
  maze.obs.add(new Obstacle(100, 585, 200, 30));
  maze.obs.add(new Obstacle(0, 285, 200, 30));
  maze.obs.add(new Obstacle(600, 285, 100, 30));
  maze.obs.add(new Obstacle(500, 185, 300, 30));
  maze.obs.add(new Obstacle(400, 85, 200, 30));
  maze.obs.add(new Obstacle(685, 700, 30, 100));
  maze.obs.add(new Obstacle(185, 700, 30, 100));
  maze.obs.add(new Obstacle(585, 600, 30, 200));
  maze.obs.add(new Obstacle(485, 500, 30, 200));
  maze.obs.add(new Obstacle(385, 500, 30, 200));
  maze.obs.add(new Obstacle(285, 600, 30, 200));
  maze.obs.add(new Obstacle(185, 300, 30, 200));
  maze.obs.add(new Obstacle(85, 400, 30, 300));
  maze.obs.add(new Obstacle(85, 0, 30, 200));
  maze.obs.add(new Obstacle(585, 300, 30, 200));
  maze.obs.add(new Obstacle(485, 200, 30, 200));
  maze.obs.add(new Obstacle(285, 100, 30, 300));
  maze.obs.add(new Obstacle(185, 100, 30, 100));
  maze.obs.add(new Obstacle(385, 0, 30, 300));
  maze.obs.add(new Obstacle(400, 685, 100, 30));
}

void draw(){
  background(255);
  maze.show();
  textSize(20);
  text("Generation: " + gen, 875, 25);
  text("Total steps: " + stepCount,875, 50);
  if (fewestSteps.size() > 1) {
    if (!fewestSteps.get(fewestSteps.size() - 1).isEmpty) {
      text("Fewest steps: " + fewestSteps.get(fewestSteps.size() - 1).data, 875, 75);
    }
  }
  
  if(population.allDotsDead()){
    population.nextGoal();
    population.processGraphs();
    population.naturalSelection();
    population.mutate();
  }
  
  population.update();
  population.show();
  ArrayList<ArrayList<Datapoint>> fitnessGraphs = new ArrayList<ArrayList<Datapoint>>();
  ArrayList<int[]> fitnessGraphColors = new ArrayList<int[]>();
  fitnessGraphs.add(maxFitness);
  fitnessGraphColors.add(new int[] { 0, 0, 0 });
  fitnessGraphs.add(avgFitness);
  fitnessGraphColors.add(new int[] { 255, 0, 0 });
  ArrayList<ArrayList<Datapoint>> stepGraphs = new ArrayList<ArrayList<Datapoint>>();
  ArrayList<int[]> stepGraphColors = new ArrayList<int[]>();
  stepGraphs.add(fewestSteps);
  stepGraphColors.add(new int[] { 0, 0, 0 });
  stepGraph.show(stepGraphs, stepGraphColors);
  fitnessGraph.show(fitnessGraphs, fitnessGraphColors);
}
