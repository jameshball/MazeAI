/* This class can be ignored if you are looking at how the genetic algorithm works. */
class Graph {
  int posx;
  int posy;
  int graphWidth;
  int graphHeight;
  int weight;
  String xlabel;
  String ylabel;
  
  Graph (int inputx, int inputy, String inputxlabel, String inputylabel, int inputWidth, int inputHeight, int inputWeight) {
    posx = inputx;
    posy = inputy;
    graphWidth = inputWidth;
    graphHeight = inputHeight;
    weight = inputWeight;
    xlabel = inputxlabel;
    ylabel = inputylabel;
  }
  
  void show(ArrayList<ArrayList<Datapoint>> data, ArrayList<int[]> colors) {
    if (data.get(0).size() > 1) {
      strokeWeight(weight);
      smooth();
      float lineWidth = (float)graphWidth/(data.get(0).size()-1);
      float valueRange = getMax(data) - getMin(data);
      float lineHeight = 0.0;
      
      int scaleCount = 1;
      
      while (valueRange < 1 && valueRange != 0.0) {
        int scaleAmount = 10;
        
        data = scale(data, scaleAmount);
        scaleCount *= scaleAmount;
        
        valueRange = getMax(data) - getMin(data);
      }
      
      if (valueRange != 0) {
        lineHeight = ((float)graphHeight / valueRange);
      }
      
      int widthShowingRate = showingRate(data.get(0).size(), graphWidth, false) + 1;
      int heightShowingRate = showingRate(valueRange + 1, graphHeight, true);
      
      textSize(14);
      fill(0);
      
      text(xlabel, posx + 10 - textWidth(xlabel) / 2 + graphWidth / 2, posy + graphHeight + 50);
      
      String newylabel = ylabel;
      
      if (scaleCount != 1) {
        newylabel = ylabel + " (coded x" + scaleCount + ")";
      }
      
      int x = posx - 70;
      int y = posy - (int)textWidth(newylabel) / 2 + graphHeight / 2;
      
      pushMatrix();
      translate(x,y);
      rotate(HALF_PI);
      translate(-x,-y);
      text(newylabel, x,y);
      popMatrix();
      
      if ((int)data.get(0).get(data.get(0).size() - 1).data == data.get(0).get(data.get(0).size() - 1).data) {
        for (int i = 0; i < valueRange + 1; i++) {
          if (heightShowingRate == 0 || i % heightShowingRate == 0) {
            text((int)(getMin(data) + i), posx - 40, posy + graphHeight - i*lineHeight + 5);
          }
        }
      }
      else {
        for (float i = 0; i < valueRange + 0.2; i = i + 0.2) {
          i = Precision.round(i, 2);
          
          if (heightShowingRate == 0 || i % heightShowingRate == 0) {
            text(getMin(data) + i, posx - 40, posy + graphHeight - i*lineHeight + 5);
          }
        }
      }
        
      for (int i = 0; i < data.size(); i++) {
        stroke(colors.get(i)[0], colors.get(i)[1], colors.get(i)[2]);
        for (int j = 0; j < data.get(i).size() - 1; j++) {
          if (!data.get(i).get(j).isEmpty) {
            float value1 = data.get(i).get(j).data - getMin(data);
            float value2 = data.get(i).get(j + 1).data - getMin(data);
            
            line(j*lineWidth + posx + 10, posy + graphHeight - (lineHeight * value1), (j+1)*lineWidth + posx + 10, posy + graphHeight - (lineHeight * value2));
          }
        }
      }
      
      for (int i = 0; i < data.get(0).size(); i++) {
        if (widthShowingRate == 0 || i % widthShowingRate == 0) {
          String text = Integer.toString((int)(gen - data.get(0).size() + i));
          text(text, i*lineWidth + posx + 10 - textWidth(text) / 2, posy + graphHeight + 20);
        }
      }
      
      strokeWeight(1);
    }
  }
  
  Float getMax(ArrayList<ArrayList<Datapoint>> list) {
    Datapoint max = new Datapoint(true);
    
    for (int i = 0; i < list.size(); i++) {
      for (int j = 0; j < list.get(i).size(); j++) {
        if (!list.get(i).get(j).isEmpty) {
          if (max.isEmpty) {
            max.data = list.get(i).get(j).data;
            max.isEmpty = false;
          }
          else if (list.get(i).get(j).data > max.data) {
            max.data = list.get(i).get(j).data;
          }
        }
      }
    }
    
    return max.data;
  }
  
  Float getMin(ArrayList<ArrayList<Datapoint>> list) {
    Datapoint min = new Datapoint(true);
    
    for (int i = 0; i < list.size(); i++) {
      for (int j = 0; j < list.get(i).size(); j++) {
        if (!list.get(i).get(j).isEmpty) {
          if (min.isEmpty) {
            min.data = list.get(i).get(j).data;
            min.isEmpty = false;
          }
          else if (list.get(i).get(j).data < min.data) {
            min.data = list.get(i).get(j).data;
          }
        }
      }
    }
    
    return min.data;
  }

  
  int showingRate(float val, int dimension, boolean isVertical) {
    float rate;
    
    if (isVertical) {
      rate = dimension / 30;
    }
    else {
      rate = dimension / 20;
    }
    
    return (int)Math.pow(2, (Math.log(val/rate)/Math.log(2)) + 1);
  }
  
  ArrayList<ArrayList<Datapoint>> scale (ArrayList<ArrayList<Datapoint>> data, int scale) {
    for (int i = 0; i < data.size(); i++) {
      ArrayList<Datapoint> scaledList = new ArrayList<Datapoint>();
      
      for (int j = 0; j < data.get(i).size(); j++) {
        scaledList.add(new Datapoint(data.get(i).get(j).data * scale, false));
      }
      
      data.set(i, scaledList);
    }
    
    return data;
  }
}
