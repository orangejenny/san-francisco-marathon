class Photo {
  public String name;
  public float mile;
  public String file;
  public int photo_width;
  public int photo_height;
  public float x_in_miles;
  public int y_in_miles;
  
  public Photo(String n, float m, String f, float x, int y_level) {
    this.name = n;
    this.mile = m;
    this.file = f;
    this.photo_width = 333;
    this.photo_height = 207;
    this.x_in_miles = x;
    this.y_in_miles = y_level * 120;
  }
}

void drawPhotos() {
  Photo[] photos = {new Photo("Ferry Building", 0.2, "ferry_building2.jpg", 0.2, 4),
                    new Photo("Seals at Pier 39", 1.5, "seals.jpg", 0.2, 3),
                    new Photo("Fort Mason", 2.5, "fort_mason.jpg", 0.2, 2),
                    new Photo("Palace of Fine Arts", 3.7, "palace2.jpg", 3.7, 4),
                    new Photo("Crissy Field", 4.8, "crissy_field.jpg", 3.7, 3),
                    new Photo("Golden Gate Bridge", 7.5, "gg_bridge.jpg", 7.2, 4),
                    new Photo("Japanese Tea Garden", 17.5, "tea_garden.jpg", 15.9, 1),
                    new Photo("Piedmont Boutique", 19.4, "haight_legs.jpg", 19.4, 1),
                    new Photo("Roxie Theatre", 21.3, "roxie.jpg", 19.4, 2), 
                    new Photo("China Basin", 24.6, "china_basin.jpg", 22.9, 1),
                    new Photo("AT&T Park", 25.1, "att_park2.jpg", 22.9, 2),
                    new Photo("Bay Bridge", 26, "bay_bridge2.jpg", 22.9, 3)};
  float x = 0;
  float y = 0;
  PImage photo = null;
  setFont(24);
  textAlign(LEFT);
  
  //setStroke(0.75, 2);
  int neighborhood_index = 0;
  for (int i = 0; i < photos.length; i++) {
    x = graph_origin.x + photos[i].mile * mile_width + 1;
    y = graph_origin.y - photos[i].y_in_miles * scale;

    while (neighborhood_index < neighborhoods.length && neighborhoods[neighborhood_index].end < photos[i].mile) {
      neighborhood_index++;
    }
    strokeWeight(4);
    stroke(neighborhoods[neighborhood_index].bg_color, 128);
    line(x, line_origin.y + radius * 1.5, x, y);
    /*for (int j = line_origin.y; j < y; j += 6) {
      point(x, j);
    }*/
  }
  setStroke(1, 1);
  
  neighborhood_index = 0;
  for (int i = 0; i < photos.length; i++) {
    photo = loadImage(photos[i].file);
    
    x = graph_origin.x + photos[i].x_in_miles * mile_width;
    y = graph_origin.y - photos[i].y_in_miles * scale;
    
    noStroke();
    fill(58, 58, 58);
    rect(x, y, photos[i].photo_width + padding * 2, photos[i].photo_height + padding * 2 + line_height);
    image(photo, x + padding, y + padding + line_height);
    fill(232, 232, 232);
    text(photos[i].name + ", mile " + photos[i].mile, x + padding, y + line_height);
  }
}
