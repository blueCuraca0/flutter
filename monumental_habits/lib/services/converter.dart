class Converter {

  static String datetimeToString(DateTime dateTime) {
    return dateTime.toString().substring(0, 10);
  }

  static DateTime stringToDatetime(String string) {
    return DateTime.tryParse(string)!;
  }

  static String subtractDaysStringToString(String string, int days) {
    DateTime date = stringToDatetime(string);
    date = date.subtract(Duration(days: days));
    string = datetimeToString(date);
    return string;
  }

  static DateTime subtractDaysStringToDatetime(String string, int days) {
    return (stringToDatetime(string)).subtract(Duration(days: days));
  }

  static Map<String, bool> mapDatetimeToString(Map<DateTime, bool> dateTimeMap) {
    return dateTimeMap.map((key, value) {
      String keyString = Converter.datetimeToString(key);
      return MapEntry(keyString, value);
    });
  }

  static Map<DateTime, bool> mapStringToDatetime(Map<String, bool> dateTimeMap) {
    return dateTimeMap.map((key, value) {
      return MapEntry(DateTime.parse(key), value);
    });
  }

}