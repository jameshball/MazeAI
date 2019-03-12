import java.math.*;

Population population;
Maze maze;
Graph stepGraph;
Graph fitnessGraph;

int gen = 0;
int popSize = 2000;
/* The initial number of allowed steps (this increases over time). */
int stepCount = 60;

ArrayList<Datapoint> fewestSteps = new ArrayList<Datapoint>();
ArrayList<Datapoint> maxFitness = new ArrayList<Datapoint>();
ArrayList<Datapoint> avgFitness = new ArrayList<Datapoint>();

/* Size of the area the dots can travel in. */
int mazeWidth = 800;
int mazeHeight = 800;

void setup() {
  size(1600, 800, P2D);
  frameRate(144);
  smooth();
  /* Creates a new population of dots. */
  population = new Population(popSize);
  maze = new Maze();
  stepGraph = new Graph(900, 90, "Generation", "Step Count" , 670, 275, 4);
  fitnessGraph = new Graph(900, 470, "Generation", "Fitness" , 670, 275, 4);
  
  /* Defines the location of the goal. Adding multiple goals can create a path for
     the dots to take. */
  maze.goals.locations.add(new PVector(40, 600));
  /* This horrible bit of code creates all parts of the maze. Create a new obstacle
     on the screen by adding a new obstacle to the maze.obs list, or remove all
     this code to make your own maze or obstacle. */
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
  /* Displays all obstacles and goals. */
  maze.show();
  
  /* This code writes the current generation number, number of allowed steps and
     the number of steps that the best dot took to reach the goal. */
  textSize(20);
  text("Generation: " + gen, 875, 25);
  text("Total steps: " + stepCount,875, 50);
  if (fewestSteps.size() > 1) {
    if (!fewestSteps.get(fewestSteps.size() - 1).isEmpty) {
      text("Fewest steps: " + fewestSteps.get(fewestSteps.size() - 1).data, 875, 75);
    }
  }
  
  /* If all of the dots have died, start the next generation. */
  if(population.allDotsDead()){
    population.nextGoal();
    population.processGraphs();
    /* This function selects the dots that are to be cloned and placed in the next
       generation. */
    population.naturalSelection();
    /* This mutates all of the current population to hopefully introduce new, helpful
       movements. */
    population.mutate();
  }
  
  /* Move all dots and draws them to screen. */
  population.update();
  population.show();
  
  /* This code can be ignored if you are trying to learn the genetic algorithm. */
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
