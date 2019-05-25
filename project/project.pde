
Tank t = new Tank(400, 300, 20);

void setup() {
  size(800, 600);
  surface.setResizable(true);
  smooth(3);
}

void draw() {
  background(#3f3f3f);
  fill(120);
  square(400,300,30);
  t.keyPressed();
  t.update();
  t.show();
}
