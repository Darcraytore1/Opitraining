class Coach {

  String firstName;
  String name;
  String city;
  int pricePerHour;
  List<String> dayAvailable;
  String phone;
  String description;
  String email;
  String urlImage;

  Coach(String firstName, String name, String city, int pricePerHour, List<String> dayAvailable, String phone, String description, String email, String urlImage) {
    this.firstName = firstName;
    this.name = name;
    this.city = city;
    this.pricePerHour = pricePerHour;
    this.dayAvailable = dayAvailable;
    this.phone = phone;
    this.description = description;
    this.email = email;
    this.urlImage = urlImage;
  }

  String getFirstName() {
    return firstName;
  }

  String getName() {
    return name;
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

  String getPhone() {
    return phone;
  }

  String getDescription() {
    return description;
  }

  String getEmail() {
    return email;
  }

  String getUrlImage() {
    return urlImage;
  }

  String toStringDayAvailable() {
    if (dayAvailable.isEmpty) return "Non précisé";
    if (dayAvailable.length == 7) return "Tous les jours de la semaine";
    else {
      String days = "";
      for (int i = 0; i < dayAvailable.length; i++) {
        if (i == dayAvailable.length - 1) {
          days += dayAvailable[i];
        } else {
          days += dayAvailable[i] + ", ";
        }
      }
      return days;
    }
  }

  Map<String,dynamic> json() {
    return {
      "availability": dayAvailable,
      "city": city,
      "first_name": firstName,
      "name": name,
      "price": pricePerHour,
      "phone": phone,
      "description": description,
      "image" : urlImage
    };
  }
}