class Circle {
  float x, y, r;       // Position and radius
  boolean grow;        // Whether the circle should still grow
  color c;             // Circle color

  // Constructor initializing circle position, color, radius, and growth state.
  Circle(float _x, float _y, color _c) {
    x = _x;
    y = _y;
    r = 1;             
    c = _c;
    grow = true;
  }

  // Draws the circle on the canvas with its current color and size.
  void show() { 
    fill(c);
    noStroke();
    circle(x, y, r*2);  
  }

  // Increases the circle's radius if it is still allowed to grow.
  void grow() {
    if (grow) r += growSpeed;      
  }

  // Checks if the circle has reached the canvas boundaries.
  // Returns true if touching or beyond any edge.
  boolean edges() {
    return (x + r > width || x - r < 0 || y + r > height || y - r < 0); 
  }
}