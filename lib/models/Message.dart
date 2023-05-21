import 'package:flutter/cupertino.dart';

@immutable
class Message {
  final String text;
  final bool sentByUser;
  final List<String> results;

  const Message({required this.text, required this.sentByUser, required this.results});
}