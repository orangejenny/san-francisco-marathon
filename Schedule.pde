void drawSchedule() {
  int num_weeks = days.length;
  GregorianCalendar cal = new GregorianCalendar();
  cal.set(2010, Calendar.JULY, 25);
  cal.set(Calendar.DAY_OF_YEAR, cal.get(Calendar.DAY_OF_YEAR) - num_weeks * 7 + 1);
  ArrayList months = getMonthList();
  
  // Map in background
  noStroke();
  //fill(153, 192, 220, 128);
  fill(127, 178, 204, 1);
  rect(schedule_origin.x, schedule_origin.y, mile_width * 3.8, schedule_height);
  rect(schedule_origin.x + mile_width * 22.42, schedule_origin.y, mile_width * 3.8, schedule_height);
  tint(255, 255, 255, 128);
  image(loadImage("sfm_course_abstract.png"), schedule_origin.x + mile_width * 3.8, schedule_origin.y);
  noTint();
  fill(0);
  stroke(0);
  
  // Calendar structure
  noFill();
  textAlign(RIGHT);
  setStroke(0.25, 1);
  rect(schedule_origin.x, schedule_origin.y, body_width / num_weeks * num_weeks, schedule_height);    // outer rectangle
  String[] days_of_week = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
  String[] days_of_week_workout = {"Recovery", "Hills", "Intervals", "Short Run", "Rest", "Short Run", "Long Run"};
  for (int i = 0; i < days_of_week.length; i++) {
    setFontBold(24);
    text(days_of_week[i], schedule_origin.x - padding, schedule_origin.y + i * schedule_height / 7 + line_height);
    setFont(24);
    text(days_of_week_workout[i], schedule_origin.x - padding, schedule_origin.y + i * schedule_height / 7 + line_height * 2);
  }
  setFont(24);
  textAlign(LEFT);
  
  // Individual days
  float x = 0;
  float y = 0;
  float month_x_val = schedule_origin.x;
  String month_text = "";
  String date = "";
  for (int i = 0; i < num_weeks; i++) {
    for (int j = 0; j < 7; j++) {
      setStroke(0.25, 1);
        
      x = schedule_origin.x + i * (body_width / num_weeks);
      y = schedule_origin.y + j * (schedule_height / 7);
      date = (months.indexOf(cal.get(Calendar.MONTH)) + 1) + "/" + cal.get(Calendar.DAY_OF_MONTH);
      
      rect(x, y, body_width / num_weeks, schedule_height / 7);
      text(date, x + padding, y + line_height);
      if (i == num_weeks - 1 && j == 6) {
        setFontBold(24);
        text("RACE", x + padding, y + line_height * 2);
        setFont(24);
      }
      else {
        text(days[i][j].toString(), x + padding, y + line_height * 2);
      }
      if (cal.get(Calendar.DAY_OF_MONTH) == 1) {
        month_text = getMonthText(cal.get(Calendar.MONTH) - 1);
        setStroke(1, 1);
        textAlign(CENTER);
        setFontBold(24);
        text(month_text, (x + body_width / num_weeks + month_x_val) / 2, schedule_origin.y - padding);
        setFont(24);
        textAlign(LEFT);
        month_x_val = x + body_width / num_weeks;
        
        setStroke(0.5, 1);
        if (cal.get(Calendar.DAY_OF_WEEK) != Calendar.MONDAY) {
          line(x, y, x + body_width / num_weeks, y);
        }
        line(x + body_width / num_weeks, y, x + body_width / num_weeks, schedule_origin.y);
        line(x, y, x, schedule_origin.y + schedule_height);
      }
      cal.set(Calendar.DAY_OF_YEAR, cal.get(Calendar.DAY_OF_YEAR) + 1);
    }
  }
  setStroke(1, 1);
  setFontBold(24);
  text(getMonthText(cal.get(Calendar.MONTH)), (schedule_origin.x + body_width + month_x_val) / 2, schedule_origin.y - padding);
  
  /* Weekly mileage */
  float total = 0;
  x = schedule_origin.x;
  cal.set(Calendar.DAY_OF_YEAR, cal.get(Calendar.DAY_OF_YEAR) - num_weeks * 7 + 6);
  setStroke(0.25, 1);
  for (int i = 0; i < num_weeks; i++) {
    total += mileage[i];
    text(numToString(total), x + padding, schedule_origin.y + schedule_height + line_height);
    x += body_width / num_weeks;
    line(x, schedule_origin.y + schedule_height, x, graph_origin.y);
    date = (months.indexOf(cal.get(Calendar.MONTH)) + 1) + "/" + cal.get(Calendar.DAY_OF_MONTH);
    textAlign(CENTER);
    text(date, x, graph_origin.y + line_height);
    textAlign(LEFT);
    cal.set(Calendar.DAY_OF_YEAR, cal.get(Calendar.DAY_OF_YEAR) + 7);
  }
  textAlign(RIGHT);
  setFontBold(24);
  text("Total Miles", schedule_origin.x - padding, schedule_origin.y + schedule_height + line_height);
  line(schedule_origin.x, schedule_origin.y + schedule_height, schedule_origin.x, graph_origin.y);
  setFont(24);
  textAlign(LEFT);
}

ArrayList getMonthList() {
  ArrayList rv = new ArrayList(12);
  rv.add(Calendar.JANUARY);
  rv.add(Calendar.FEBRUARY);
  rv.add(Calendar.MARCH);
  rv.add(Calendar.APRIL);
  rv.add(Calendar.MAY);
  rv.add(Calendar.JUNE);
  rv.add(Calendar.JULY);
  rv.add(Calendar.AUGUST);
  rv.add(Calendar.SEPTEMBER);
  rv.add(Calendar.OCTOBER);
  rv.add(Calendar.NOVEMBER);
  rv.add(Calendar.DECEMBER);
  return rv;
}

String getMonthText(int m) {
  String rv = "";
  switch (m) {
    case Calendar.JANUARY:
      rv = "January";
      break;
    case Calendar.FEBRUARY:
      rv = "February";
      break;
    case Calendar.MARCH:
      rv = "March";
      break;
    case Calendar.APRIL:
      rv = "April";
      break;
    case Calendar.MAY:
      rv = "May";
      break;
    case Calendar.JUNE:
      rv = "June";
      break;
    case Calendar.JULY:
      rv = "July";
      break;
    case Calendar.AUGUST:
      rv = "August";
      break;
    case Calendar.SEPTEMBER:
      rv = "September";
      break;
    case Calendar.OCTOBER:
      rv = "October";
      break;
    case Calendar.NOVEMBER:
      rv = "November";
      break;
    case Calendar.DECEMBER:
      rv = "December";
      break;
  }
  return rv;
}
