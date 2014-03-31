import processing.pdf.*;

/* Globals for drawing */
int canvas_width = 1000;
int canvas_height = 700;
int body_width = 884;
int body_height = 250;

/* Global data */
float[] sundays = {8, 10, 6, 12, 14, 8, 16, 18, 10, 20, 8, 20, 12, 20, 12, 10, 8, 26.2};
int num_weeks = sundays.length;

void setup() {
  size(canvas_width, canvas_height, PDF, "sketch.pdf");
  background(200, 200, 200);
  
  stroke(0);
  fill(0);
  PFont font;
  font = loadFont("Helvetica-9.vlw");
  textFont(font, 12);
  
  Point origin = new Point();
  float mile_width = body_width / 26.2;
  
  float x = 0;
  float y = 0;
  
  /* Schedule */
  origin.x = (width - body_width) / 2;
  origin.y = 20;
  noFill();
  stroke(0, 0, 0, 16);
  for (int i = 0; i < 7; i++) {
    for (int j = 0; j < num_weeks; j++) {
      x = origin.x + j * (body_width / num_weeks);
      y = origin.y + i * (body_height / 7);
      rect(x, y, body_width / num_weeks, body_height / 7);
      text((int)sundays[j], x + 3, y + 15);
    }
  }
  rect(origin.x, origin.y, body_width / num_weeks * num_weeks, body_height / 7 * 7);    // outer rectangle
  
  /* Race line */
  stroke(0, 0, 32);
  origin.y = height - 20;
  line(origin.x, height / 2, origin.x + body_width, height / 2);
  for (int i = 1; i < 27; i++) {
    if (i % 13 != 0) {
      drawCircle(i, origin);
    }
  }
  drawCircle(13.1, origin);
  drawCircle(26.2, origin);
    
  /* Graph */
  
  // Axes
  int scale = 1;
  stroke(0);
  line(origin.x, origin.y, origin.x + body_width, origin.y);
  line(origin.x + body_width, origin.y, origin.x + body_width, origin.y - body_height);
  stroke(0, 0, 0, 16);
  line(origin.x, origin.y - 100 * scale, origin.x + body_width, origin.y - 100 * scale);
  line(origin.x, origin.y - 200 * scale, origin.x + body_width, origin.y - 200 * scale);
  
  // Data
  float total_miles = 0;
  float x1 = 0;
  float x2 = 0;
  float y1 = 0;
  float y2 = 0;
  float y3 = 0;
  float y4 = 0;
  for (int i = 0; i < num_weeks; i++) {
    noStroke();
    x1 = origin.x + (i > 0 ? (i - 1) * body_width / (num_weeks - 1) : 0);
    x2 = origin.x + i * body_width / (num_weeks - 1);
    y1 = origin.y - (i > 0 ? (total_miles - sundays[i - 1]) * scale : 0);
    y2 = origin.y - total_miles * scale;
    fill(0, 0, 255, 128);
    quad(x1, y1, x2, y2, x2, origin.y, x1, origin.y);
    y3 = y2;
    total_miles += sundays[i];
    y4 = origin.y - total_miles * scale;
    fill(0, 255, 0, 128);
    quad(x1, y1, x2, y2, x2, y4, x1, y3);
  }
  
  exit();
}

void drawCircle(float mile_mark, Point o) {
    float x = o.x + mile_mark * (body_width / 26.2);
    float y = height / 2;
    int radius = 15;
    
    stroke(0);
    fill(200, 200, 200);
    ellipse(x, y, radius * 2, radius * 2);
    
    fill(0);
    int offset = 0;

    String num_string = "";
    if (Math.floor(mile_mark) == mile_mark) {
      num_string = new Integer((int)mile_mark).toString();
    }
    else {
      num_string = (new Float(mile_mark)).toString();
    }
    text(num_string, x - 3 * num_string.length(), y + 5);
    
    stroke(0, 0, 0, 32);
    line(x, y + radius, x, o.y);
}
