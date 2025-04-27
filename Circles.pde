ArrayList<Circle> circles; //<>//
PImage image;
Circle c;
float growSpeed;

void setup() {
  size(1100, 1100);
  circles = new ArrayList<Circle>();
  image = loadImage("raptor.jpg");
  image.resize(width, height);
  image.loadPixels();
  growSpeed = 0.0125; //Change this value to vary the resolution
}

void draw() {
  background(20);

  int total = 200;
  int count = 0;
  int attempts = 0;

  while (count < total) {
    c = newCircle();
    if (c != null) {
      circles.add(c);
      count++;
    }
    attempts++;
    if (attempts > 5000) {
      noLoop();
      println("Finished");  
      break;
    }
  }

  for (Circle c : circles) {
    if (c.grow) {
      if (c.edges()) {
        c.grow = false;
      } else {
        for (Circle other : circles) {
          if (c != other) {
            float d = dist(c.x, c.y, other.x, other.y);
            if (d < c.r + other.r) {
              c.grow = false;
              break;
            }
          }
        }
      }
    }
    c.show();
    c.grow();
  }
}

Circle newCircle() {

  int x = int(random(image.width));
  int y = int(random(image.height));
  boolean valid = true;

  for (Circle c : circles) {
    float d = dist(x, y, c.x, c.y);
    if (d < c.r + 3) {
      valid = false;
      break;
    }
  }
  
  int index = int(x + y * image.width);
  color c = image.pixels[index];

  if (valid) {
    return new Circle(x, y, c);
  } else {
    return null;
  }
}


void mousePressed() {
  saveFrame("screenshot.jpg");
}
