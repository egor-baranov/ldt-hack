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