class Circle {
  float x, y, r;
  boolean grow;
  color c;

  Circle(float _x, float _y, color _c) {
    x = _x;
    y = _y;
    r = 1;
    c = _c;
    grow = true;
  }

  void show() {
    fill(c);
    noStroke();
    circle(x, y, r*2);
  }

  void grow() {
    if (grow) r+=growSpeed;
  }

  boolean edges() {
    return (x + r > width || x -  r < 0 || y + r > height || y -r < 0);
  }
}
