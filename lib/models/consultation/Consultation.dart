import 'dart:convert';

class ConsultationModel {
  String? id;
  String? title;
  String? description;

  // format: 15.04.2023
  String? day;

  // format: 13:00
  String? time;

  List<String>? tags;

  ConsultationModel({
    this.id,
    this.title,
    this.description,
    this.day,
    this.time,
    this.tags,
  });

  ConsultationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    day = json['day'];
    time = json['time'];
    tags = (jsonDecode(json['tags']) as List<dynamic>)
        .map((e) => e as String)
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'day': day,
      'time': time,
      'tags': jsonEncode(tags),
    };
  }
}
