import 'package:flutter/cupertino.dart';

@immutable
class Message {
  final String text;
  final bool sentByUser;

  Message({required this.text, required this.sentByUser});
}