class Coach {
  String fullName;
  String city;
  int pricePerHour;
  List<String> dayAvailable;

  Coach(String fullName, String city, int pricePerHour, List<String> dayAvailable) {
    this.fullName = fullName;
    this.city = city;
    this.pricePerHour = pricePerHour;
    this.dayAvailable = dayAvailable;
  }

  String getFullName() {
    return fullName;
  }

  String getCity() {
    return city;
  }

  int getPricePerHour() {
    return pricePerHour;
  }

  List<String> getDayAvailable() {
    return dayAvailable;
  }

  String toStringDayAvailable() {
    if (dayAvailable.length == 7) return "Tous les jours de la semaine";
    else {
      String days = "";
      for (int i = 0; i < dayAvailable.length; i++) {
        if (i == dayAvailable.length - 1) {
          days += dayAvailable[i];
        } else {
          days += dayAvailable[i] + ",";
        }
      }
      return days;
    }
  }
}