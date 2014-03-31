/* Globals for data */
Workout[][] days = buildSchedule();
int num_weeks = days.length;
float[] mileage = buildMileage(days);

/* Globals for drawing */
int canvas_width = 3384;
int canvas_height = 2520;
int canvas_background_color = #ffffff;
int body_width = 3000 / num_weeks * num_weeks;
float mile_width = body_width / 26.2;
int schedule_height = 1000 / 7 * 7;
int graph_height = 1200;
Point schedule_origin = new Point((canvas_width - body_width) / 2, 50);
Point line_origin = new Point(schedule_origin.x, schedule_origin.y + schedule_height + 100);
Point graph_origin = new Point(schedule_origin.x, canvas_height - 50);

int padding = 15;
int line_height = 35;
float scale = 2.5;

/* Neighborhoods - global because they're accessed by both RaceLine and Photo */
int[] ncolors = {#5B92D9, #735340, #D9483B, #735340, #D9CC1A, #518C5A, #BFA065, #8C0303, #020F59, #F2E96D};

Neighborhood[] neighborhoods = {new Neighborhood("Embarcadero", 0, 2.1, ncolors[0]),
                                new Neighborhood("Presidio", 2.1, 5.3, ncolors[1]),
                                new Neighborhood("Golden Gate Bridge", 5.3, 9.7, ncolors[2]),
                                new Neighborhood("Presidio", 9.7, 11.1, ncolors[3]),
                                new Neighborhood("Richmond", 11.1, 12.5, ncolors[4]),
                                new Neighborhood("Golden Gate Park", 12.5, 19.1, ncolors[5]),
                                new Neighborhood("Haight", 19.1, 20.6, ncolors[6]),
                                new Neighborhood("Mission", 20.6, 22.3, ncolors[7]),
                                new Neighborhood("Potrero Hill", 22.3, 24.7, ncolors[8]),
                                new Neighborhood("South Beach", 24.7, 26.2, ncolors[9])};

void setup() {
  size(canvas_width, canvas_height);
  background(canvas_background_color);
  smooth();

  setFont(24);
  
  float x = 0;
  float y = 0;

  drawSchedule();
  
  drawGraph("weekly");

  drawPhotos();

  drawRaceLine();
  
  setFont(96);
  textAlign(RIGHT);
  fill(canvas_background_color);
  text("Training for San Francisco", graph_origin.x + body_width / 2, graph_origin.y - padding);
  
  // Save as image
  /*DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss");
  Date today = new Date();
  save("sketch" + dateFormat.format(today) + ".png");*/
  save("poster.png");
}

String numToString(float f) {
  String rv = String.valueOf(f);
  if (f == Math.floor(f)) {
    rv = rv.substring(0, rv.indexOf("."));
  }
  return rv;
}

void setStroke(float opacity, int width) {
  stroke(0, 0, 0, 256 * opacity - 1);
  strokeWeight(width * 2);
}

void setFont(int size) {
  PFont font;
  font = loadFont("HelveticaNeue-" + size + ".vlw");
  textFont(font, size);
}

void setFontBold(int size) {
  PFont font;
  font = loadFont("HelveticaNeue-Bold-" + size + ".vlw");
  textFont(font, size);
}
