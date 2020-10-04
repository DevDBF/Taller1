  
PImage original;
PImage procesada;

float edge[][]={ //destacar los bordes 
  {-1,-1,-1},
  {-1, 8,-1},
  {-1,-1,-1}
};

float sharpen[][]={//nitidez
  {0, -1, 0},
  {-1, 5,-1},
  {0, -1, 0}
};

float identity[][]={
  {0, 0, 0},
  {0, 1, 0},
  {0, 0, 0}
};

float a = sqrt(10);
float sobel[][]={//deteccion de bordes
  {1/(2+a), 0, -1/(2+a)},
  {a/(2+a), 0, -a/(2+a)},
  {1/(2+a), 0, -1/(2+a)}
};

float b = 9;
float blur[][]={ //difuminar normalizado
  {1/b, 1/b, 1/b},
  {1/b, 1/b, 1/b},
  {1/b, 1/b, 1/b}
};

float k = 16;
float Gblur[][]={ //difuminar Gauss
  {1/k, 2/k, 1/k},
  {2/k, 4/k, 2/k},
  {1/k, 2/k, 1/k}
};

void setup() {
  
  original = loadImage("cyt.png");//carga la imagen
  //filtros: edge, sharpen, identity, sobel, blur
  procesada = convoluciones(original,blur);
  surface.setSize(original.width*2, original.height);
  
}

void draw() {
  image(original, 0, 0);
  image(procesada, original.width, 0);  
}

PImage convoluciones(PImage original, float [][]mascara){
  int x,y,i,j,k,l;
  int mitad;
  int inicio, fin;
  int tan = mascara.length;
  procesada = createImage(original.width, original.height, RGB);
  original.loadPixels();
  procesada.loadPixels();
  
  mitad = int(tan/2);
  inicio = -mitad;
  fin = mitad;
  
  float r,g,b;
  
  for(y = mitad; y < original.height-mitad; y++){
    for(x = mitad; x < original.width-mitad; x++){
      r = 0;
      g = 0;
      b = 0;
      int loc1 = x + y*original.width;
      
      for(j = inicio, l = 0; j <= fin; j++, l++){
        for(i = inicio, k = 0; i <= fin; i++, k++){
          int loc2 = (x+i) + ((y+j)*original.width);
          r += red(original.pixels[loc2]) * mascara[k][l];
          g += green(original.pixels[loc2]) * mascara[k][l];
          b += blue(original.pixels[loc2]) * mascara[k][l];
        }
      }
      procesada.pixels[loc1] = color(r,g,b);
    }
  }
  procesada.updatePixels();
  return procesada;
}
