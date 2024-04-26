class Converter {

  static String datetimeToString(DateTime dateTime) {
    return dateTime.toString().substring(0, 10);
  }

  static DateTime stringToDatetime(String string) {
    return DateTime.tryParse(string)!;
  }

  // static

}