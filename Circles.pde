ArrayList<Circle> circles; // List to store all circles
PImage image;              // Image used for sampling colors
Circle c;                  // Temporary circle variable
float growSpeed;           // Speed at which circles grow

// Initializes the canvas, loads and resizes the image,
// prepares pixel data, and sets the circle growth speed.
void setup() {
  size(1100, 1100);
  circles = new ArrayList<Circle>();
  image = loadImage("raptor.jpg");   
  image.resize(width, height);       
  image.loadPixels();                
  growSpeed = 0.0125;                
}

// Main loop that adds new circles while avoiding overlap, 
// updates growth and drawing of all circles,
// and stops when no more circles can be placed.
void draw() {
  background(20);                  

  int total = 200;                  
  int count = 0;                    
  int attempts = 0;                 

  // Try to add new circles until total reached or attempts exceed limit
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

  // Update and display all circles
  for (Circle c : circles) {
    if (c.grow) {
      if (c.edges()) {             // Stop growth if circle hits canvas edge
        c.grow = false;
      } else {
        // Check for overlap with other circles
        for (Circle other : circles) {
          if (c != other) {
            float d = dist(c.x, c.y, other.x, other.y);
            if (d < c.r + other.r) {
              c.grow = false;      // Stop growth if overlapping another circle
              break;
            }
          }
        }
      }
    }
    c.show();                      // Draw circle
    c.grow();                      // Increase radius if allowed
  }
}

// Attempts to create a new circle at a random position
// that does not overlap existing circles and samples the image color at that position.
// Returns the new Circle or null if placement is invalid.Circle 
newCircle() {
  int x = int(random(image.width));
  int y = int(random(image.height));
  boolean valid = true;

  // Check if new circle overlaps existing ones
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

// Saves a screenshot of the current frame when the mouse is pressed.
void mousePressed() {
  saveFrame("screenshot.jpg");     
}