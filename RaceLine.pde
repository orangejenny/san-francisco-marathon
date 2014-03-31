class Neighborhood {
  public String name;
  public float start;
  public float end;
  public int bg_color;
  
  public Neighborhood(String n, float s, float e, int bg) {
    this.name = n;
    this.start = s;
    this.end = e;
    this.bg_color = bg;
  }
  
  public float width() {
    return this.end - this.start;
  }
}

int radius = line_height;//30;

void drawRaceLine() {
  textAlign(CENTER);
  noStroke();
  
  Neighborhood n = null;
  for (int i = 0; i < neighborhoods.length; i++) {
    n = neighborhoods[i];
    fill(n.bg_color, 128);
    rect(line_origin.x + n.start * mile_width, line_origin.y - radius * 1.5, n.width() * mile_width, radius * 3);
    fill(0);
    text(n.name, line_origin.x + (n.start + n.width() / 2) * mile_width, line_origin.y + radius * 2 + padding);
  }
  
  // Race line
  stroke(0, 0, 32);
  line(line_origin.x, line_origin.y, line_origin.x + body_width, line_origin.y);
  for (int i = 1; i < 27; i++) {
    if (i % 13 != 0) {
      drawCircle(i);
    }
  }
  drawCircle(0);
  drawCircle(13.1);
  drawCircle(26.2);
}

void drawCircle(float mile_mark) {
    float x = line_origin.x + mile_mark * (body_width / 26.2);
    float y = line_origin.y;
    
    setFontBold(24);
    stroke(0);
    fill(canvas_background_color);
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
    text(num_string, x, y + 10);
    setFont(24);
}
