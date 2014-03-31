class Workout {
  public static final int HILLS = 5;
  public static final int LONG_RUN = 4;
  public static final int SHORT_RUN = 3;
  public static final int INTERVAL = 2;
  public static final int RECOVERY = 1;
  public static final int REST = 0;
  
  public int type;
  public String description;
  
  public Workout(int t, String d) {
    this.type = t;
    this.description = d;
  }
  
  float distance() {
    float rv = 0;
    if (this.type == Workout.LONG_RUN || this.type == Workout.SHORT_RUN || this.type == Workout.HILLS) {
      rv = (new Float(this.description)).floatValue();
    }
    if (this.type == Workout.INTERVAL) {
      // matches NUMBERxMETERSm
      int num = (new Integer(this.description.substring(0, this.description.indexOf("x")))).intValue();
      float distance = (new Float(this.description.substring(this.description.indexOf("x") + 1, this.description.indexOf("m")))).floatValue() / 1600;
      rv = num * distance;
    }
    return rv;
  }
  
  String toString() {
    String rv = "";
    switch (this.type) {
      case Workout.HILLS:
        rv = this.description + " miles hills";
        break;
      case Workout.LONG_RUN:
        rv = this.description + " miles";
        break;
      case Workout.SHORT_RUN:
        rv = this.description + " miles";
        break;
      case Workout.INTERVAL:
        rv = this.description;
        break;
      case Workout.RECOVERY:
        rv = "Recovery";
        break;
      case Workout.REST:
        rv = "Rest";
        break;
    }
    
    return rv;
  }
}

Workout[][] buildSchedule() {
  float[] long_runs = {8, 10, 6, 12, 14, 8, 16, 18, 10, 20, 8, 20, 12, 20, 12, 10, 8, 26.2};
  int[] hills = {3, 3, 3, 4, 5, 3, 5, 5, 5, 5, 3, 5, 3, 5, 3, 5, 5, 4};
  String[] intervals = {"2x1600m", "2x1600m", "0", "4x800m", "4x800m", "0", "5x800m", "5x800m", "0", "6x800m", "0", "6x800m", "0", "6x800m", "0", "4x800m", "3", "0"};
  int[] short_runs1 = {3, 3, 3, 4, 4, 3, 5, 5, 4, 5, 4, 5, 5, 5, 4, 5, 5, 3};
  int[] short_runs2 = {3, 3, 3, 3, 3, 3, 4, 4, 3, 4, 3, 4, 4, 4, 3, 4, 4, 0};

  Workout[][] rv = new Workout[long_runs.length][7];
  Workout[] week = new Workout[7];
  for (int i = 0; i < long_runs.length; i++) {
    week = new Workout[7];
    week[0] = new Workout(Workout.RECOVERY, "");
    if (hills[i] == 0) {
      week[1] = new Workout(Workout.REST, "");
    }
    else {
      week[1] = new Workout(Workout.HILLS, String.valueOf(hills[i]));
    }
    if (intervals[i] == "0") {
      week[2] = new Workout(Workout.REST, "");
    }
    else if (intervals[i].length() == 1) {
      week[2] = new Workout(Workout.SHORT_RUN, String.valueOf(intervals[i]));
    }
    else {
      week[2] = new Workout(Workout.INTERVAL, intervals[i]);
    }
    if (short_runs1[i] == 0) {
      week[3] = new Workout(Workout.REST, "");
    }
    else {
      week[3] = new Workout(Workout.SHORT_RUN, String.valueOf(short_runs1[i]));
    }
    week[4] = new Workout(Workout.REST, "");
    if (short_runs2[i] == 0) {
      week[5] = new Workout(Workout.REST, "");
    }
    else {
      week[5] = new Workout(Workout.SHORT_RUN, String.valueOf(short_runs2[i]));
    }
    week[6] = new Workout(Workout.LONG_RUN, numToString(long_runs[i]));
    rv[i] = week;
  }
  
  return rv;
}

float[] buildMileage(Workout[][] schedule) {
  float[] rv = new float[schedule.length];

  float m = 0;
  for (int i = 0; i < schedule.length; i++) {
    m = 0;
    for (int j = 0; j < 7; j++) {
      m += schedule[i][j].distance();
    }
    rv[i] = m;
  }
  
  return rv;
}

