/* Graph datapoint class. Can be ignored if learning the genetic algorithm. */
class Datapoint {
  float data;
  boolean isInteger;
  boolean isEmpty;
  
  Datapoint(float input, boolean integer) {
    data = input;
    isInteger = integer;
    isEmpty = false;
  }
  
  Datapoint(boolean empty) {
    isEmpty = empty;
    data = 0.0;
  }
}
