extension Datetimex on DateTime {
  String get format {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year
        ? "Today - $hour:${minute.toString().padLeft(2, "0")}"
        : "${day.toString().padLeft(2, "0")}/${month.toString().padLeft(2, "0")}/$year - $hour:${minute.toString().padLeft(2, "0")}";
  }

  String get onlyDate {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year
        ? "Today"
        : "${day.toString().padLeft(2, "0")}/${month.toString().padLeft(2, "0")}/$year";
  }

  String get onlyTime {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year
        ? "$hour:${minute.toString().padLeft(2, "0")}"
        : "$hour:${minute.toString().padLeft(2, "0")}";
  }

  int get onlyDay {
    return day;
  }
}

extension DurationX on Duration {
  String get format {
    final hour = inMinutes ~/ 60;
    final min = inMinutes % 60;
    if (hour == 0) {
      if (min != 0) {
        return "${min}min";
      } else {
        return "0";
      }
    } else {
      if (min == 0) {
        return "${hour}hour";
      } else {
        return "${hour}hour${min}min";
      }
    }
  }
}
