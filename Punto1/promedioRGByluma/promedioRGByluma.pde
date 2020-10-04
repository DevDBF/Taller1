PImage imagen;
PImage promRGB;
PImage luma;

void setup() {
  
  imagen = loadImage("loro.png");//carga la imagen
  promRGB = imagen.copy();
  luma = imagen.copy();
  promRGB.loadPixels();
  luma.loadPixels();
  
  //conversion promedio RGB
  for (int i = 0; i <promRGB.width * promRGB.height; i++) {
    //float n = 7;
    int promedioRGB = int((red(promRGB.pixels[i]) + green(promRGB.pixels[i]) + blue(promRGB.pixels[i]))/3);
    promRGB.pixels[i]= color(promedioRGB);
    //print(prom + " ");
  }
  
  //conversion luma
  for (int i = 0; i <luma.width * luma.height; i++) {
    float Iluma = ((red(luma.pixels[i])*0.2126 + green(luma.pixels[i])*0.7152 + blue(luma.pixels[i])*0.0722));
    luma.pixels[i]= color(Iluma);
    //print(prom + " ");
  }
  
  promRGB.updatePixels();
  luma.updatePixels();
  surface.setSize(imagen.width*3, imagen.height );
}

void draw() {
  
  image(imagen, 0, 0);
  image(promRGB,imagen.width,0);
  image(luma,imagen.width*2,0);  
}
