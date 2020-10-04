  
PImage original;
PImage processed;
int[] hist;

void setup() {
  
  original = loadImage("asd.jpg");//cambien la imagen
  processed = original.copy();
 
  
  hist = new int[256];

  // Calculate the histogram
  for (int i = 0; i < original.width; i++) {
    for (int j = 0; j < original.height; j++) {
      int bright = int(brightness(original.get(i, j)));
      hist[bright]++;  
    }
  }
  
  double[] probabilidad = new double[256];
  for (int i = 0; i <256; i++) {
    probabilidad[i] = (hist[i]+0.0)/(original.width*original.height);
  }


  double minThreshold = 0;
  double minVariance = Double.MAX_VALUE;

  //Calculo de Threshold minimo
  for (int t = 0; t <256; t++) {
    double c1Weight = 0;
    double c2Weight = 0;
    for (int i = 0; i <t; i++) {
      c1Weight += probabilidad[i];
    }
    for (int i = t+1; i <256; i++) {
      c2Weight += probabilidad[i];
    }
    
    double c1Mean = 0;
    double c2Mean = 0;
    for (int i = 0; i <t; i++) {
      c1Mean += (i * probabilidad[i])/c1Weight;
    }
    for (int i = t+1; i <256; i++) {
      c2Mean += (i * probabilidad[i])/c2Weight;
    }
    
    double c1Var = 0;
    double c2Var = 0;
    for (int i = 0; i <t; i++) {
      c1Var += ((i - c1Mean)* (i - c1Mean)) *(probabilidad[1]/c1Weight);
    }
    for (int i = t+1; i <256; i++) {
      c2Var += ((i - c1Mean)* (i - c1Mean))*(probabilidad[1]/c2Weight);
    }
    
    double weightedVar = 0 ;
    weightedVar = c1Weight * c1Var + c2Weight * c2Var;

    if(weightedVar < minVariance ){
      minVariance = weightedVar;
      minThreshold = t;
    }

  }
  
   processed.loadPixels();
  
  for (int i = 0; i < processed.width; i++) {
    for (int j = 0; j < processed.height; j++) {
      int bright = int(brightness(processed.get(i, j)));
      if(bright <minThreshold) {
        processed.set(i ,j ,color(0));
      }else{
        processed.set(i ,j ,color(255));
      }
    }
  }
  processed.updatePixels();
  surface.setSize(original.width*2, original.height );
  
}

void draw() {
  
  image(original, 0, 0);
  image(processed, original.width, 0);  
  int histMax = max(hist);

  stroke(255);
  // Draw half of the histogram (skip every second value)
  for (int i = 0; i < processed.width; i += 2) {
    // Map i (from 0..img.width) to a location in the histogram (0..255)
    int which = int(map(i, 0, processed.width, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(hist[which], 0, histMax, processed.height, 0));
    line(i+original.width, processed.height, i+original.width, y);
  }
}
