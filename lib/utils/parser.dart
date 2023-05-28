import 'package:lodt_hack/generated/google/protobuf/timestamp.pb.dart';

Timestamp dateFromString(String text) {
  final splitted = text.split('.').map((e) => int.parse(e)).toList();
  return Timestamp.fromDateTime(
    DateTime(splitted[2], splitted[1], splitted[0]),
  );
}

String stringFromTimestamp(Timestamp ts) {
  final dateTime = ts.toDateTime();

  String day = dateTime.day.toString();
  String month = dateTime.month.toString();

  if (dateTime.day < 10) {
    day = "0$day";
  }

  if (dateTime.month < 10) {
    month = "0$month";
  }

  return "$day.$month.${dateTime.year}";
}

bool isBlank(String? s) {
  return s == null || s.trim().isEmpty;
}

String formatDate(String date) {
  final splitted = date.split('.').map((e) => int.parse(e)).toList();
  final dt = DateTime(splitted[2], splitted[1], splitted[0]);

  if (dt.day == DateTime.now().day) {
    return "Сегодня";
  }

  if (dt.day == DateTime.now().day + 1) {
    return "Завтра";
  }

  if (dt.day == DateTime.now().day - 1) {
    return "Вчера";
  }

  if (dt.day == DateTime.now().day + 2) {
    return "Послезавтра";
  }

  if (dt.day == DateTime.now().day - 2) {
    return "Позавчера";
  }

  return "${splitted[0]} ${[
    "Января",
    "Февраля",
    "Марта",
    "Апреля",
    "Мая",
    "Июня",
    "Июля",
    "Августа",
    "Сентября",
    "Октября",
    "Ноября",
    "Декабря"
  ][splitted[1] - 1]}";
}
