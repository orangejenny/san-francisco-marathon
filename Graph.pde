void drawGraph(String type) {
  // Axes
  stroke(0);
  line(graph_origin.x, graph_origin.y, graph_origin.x + body_width, graph_origin.y);
  line(graph_origin.x + body_width, graph_origin.y, graph_origin.x + body_width, graph_origin.y - graph_height);
  drawGridLine(26.2);
  drawGridLine(100);
  drawGridLine(200);
  drawGridLine(300);
  drawGridLine(400);

  // Data
  int major_area_color = #006699;
  int minor_area_color = #00FF45;  //#339999;
  float x1 = 0;
  float x2 = 0;
  float y1 = 0;
  float y2 = 0;
  float y3 = 0;
  float y4 = 0;
  float total = 0;
  if (type == "daily") {
    float today_distance = 0;
    float yesterday_distance = 0;
    for (int i = 0; i < num_weeks; i++) {
      for (int j = 0; j < 7; j++) {
        today_distance = days[i][j].distance();
        
        x1 = graph_origin.x + (i * 7 + j) * (body_width / (num_weeks * 7));
        x2 = graph_origin.x + (i * 7 + j + 1) * (body_width / (num_weeks * 7));
        
        y1 = graph_origin.y - (total - yesterday_distance) * scale;
        y3 = graph_origin.y - total * scale;
        total += days[i][j].distance();
        y2 = graph_origin.y - (total - today_distance) * scale;
        y4 = graph_origin.y - total * scale;
        yesterday_distance = today_distance;
        
        noStroke();
        fill(major_area_color, 128);
        quad(x1, y1, x2, y2, x2, graph_origin.y, x1, graph_origin.y);
        fill(minor_area_color, 128);
        quad(x1, y1, x2, y2, x2, y4, x1, y3);
      }
    }
  }
  if (type == "weekly") {
    for (int i = 0; i < num_weeks; i++) {
      x1 = graph_origin.x + i * body_width / num_weeks;
      x2 = graph_origin.x + (i + 1) * body_width / num_weeks;
      y1 = graph_origin.y - (i > 0 ? (total - days[i - 1][6].distance()) * scale : 0);
      y3 = graph_origin.y - (i > 0 ? total : 0) * scale;
      total += mileage[i];
      y2 = graph_origin.y - (total - days[i][6].distance()) * scale;
      y4 = graph_origin.y - total * scale;
  
      noStroke();
      fill(major_area_color, 128);
      quad(x1, y1, x2, y2, x2, graph_origin.y, x1, graph_origin.y);
      fill(minor_area_color, 128);
      quad(x1, y1, x2, y2, x2, y4, x1, y3);
    }
  }

  // Labels
  setFont(48);
  fill(0);
  translate(width / 2, graph_origin.y - graph_height * 0.48);
  rotate(-PI / 7);
  textAlign(CENTER);
  if (type == "weekly") {
    text("this week's long run", 0, 0);
  }
  else {
    text("today's run", 0, 0);
  }

  //translate(0, graph_height * 0.08);
  resetMatrix();
  translate(width / 2, graph_origin.y - graph_height * 0.38);
  rotate(-PI / 7);
  text("total miles", 0, 0);
  resetMatrix();
}

void drawGridLine(float y_val) {
  stroke(0, 0, 0, 32);
  textAlign(LEFT);
  float y = graph_origin.y - y_val * scale;
  line(graph_origin.x, y, graph_origin.x + body_width, y);                        // line
  text(numToString(y_val), graph_origin.x + body_width + padding, y + 10);    // label
}
