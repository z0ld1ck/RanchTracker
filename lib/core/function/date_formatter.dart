extension DateTimeConverter on DateTime {
  String extractTime() {
    String hourString = hour >= 10 ? hour.toString() : '0$hour';
    String minuteString = minute >= 10 ? minute.toString() : '0$minute';
    return '$hourString:$minuteString';
  }

  String toDateTimeWithDots() {
    String monthString = month >= 10 ? month.toString() : '0$month';
    String dayString = day >= 10 ? day.toString() : '0$day';
    return "$dayString.$monthString.$year";
  }

  String toApiDateFormat() {
    String monthString = month >= 10 ? month.toString() : '0$month';
    String dayString = day >= 10 ? day.toString() : '0$day';
    return "$year-$monthString-$dayString";
  }
}