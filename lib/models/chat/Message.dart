import 'dart:convert';

class Message {
  String text = "";
  bool sentByUser = true;
  List<String> results = [];

  Message({
    required this.text,
    required this.sentByUser,
    required this.results,
  });

  Message.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    sentByUser = jsonDecode(json['sent_by_user']);
    results = (jsonDecode(json['results']) as List<dynamic>)
        .map((e) => e as String)
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'sent_by_user': jsonEncode(sentByUser),
      'results': jsonEncode(results),
    };
  }
}
