import 'dart:convert';
import 'package:simple_tex/misc/models/generic_model.dart';

class Pin extends GenericModel {
  late String title;
  late String markdownContent;
  late String thumbnail;

  Pin(
      {required super.id,
      required this.title,
      required this.markdownContent,
      required this.thumbnail});

  factory Pin.fromMap(Map<String, dynamic> json) {
    Pin pin = Pin(
      id: json['id'],
      markdownContent: json['markdown'],
      title: json['title'],
      thumbnail: json['thumbnail'],
    );

    return pin;
  }

  @override
  String toString() {
    return title;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {
      'id': id,
      'title': title,
      'markdown': markdownContent,
      'thumbnail': thumbnail,
    };

    return json;
  }

  String toJson() {
    Map<String, dynamic> json = toMap();
    return jsonEncode(json);
  }
}
