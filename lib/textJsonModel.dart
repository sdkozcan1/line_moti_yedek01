import 'dart:convert';

import 'package:flutter/services.dart';

class MyMotivasyonText {
  final String text;

  MyMotivasyonText({
    required this.text,
  });

  factory MyMotivasyonText.fromJson(Map<String, dynamic> json) {
    return MyMotivasyonText(
      text: json['text'],
    );
  }
}

class MyMotivasyonTextData {
  final List<MyMotivasyonText> kategoriName1Text;
  final List<MyMotivasyonText> kategoriName2Text;
  final List<MyMotivasyonText> kategoriName3Text;

  MyMotivasyonTextData({
    required this.kategoriName1Text,
    required this.kategoriName2Text,
    required this.kategoriName3Text,
  });

  factory MyMotivasyonTextData.fromJson(Map<String, dynamic> json) {
    List<dynamic> kategoriName1TextList = json['kategoriName1Text'];
    List<dynamic> kategoriName2TextList = json['kategoriName2Text'];
    List<dynamic> kategoriName3TextList = json['kategoriName3Text'];

    List<MyMotivasyonText> kategoriName1Text = kategoriName1TextList
        .map((item) => MyMotivasyonText.fromJson(item))
        .toList();
    List<MyMotivasyonText> kategoriName2Text = kategoriName2TextList
        .map((item) => MyMotivasyonText.fromJson(item))
        .toList();
    List<MyMotivasyonText> kategoriName3Text = kategoriName3TextList
        .map((item) => MyMotivasyonText.fromJson(item))
        .toList();

    return MyMotivasyonTextData(
      kategoriName1Text: kategoriName1Text,
      kategoriName2Text: kategoriName2Text,
      kategoriName3Text: kategoriName3Text,
    );
  }
}

Future<String> _loadJsonData() async {
  return await rootBundle.loadString('assets/json/mativasyonText.json');
}

Future<MyMotivasyonTextData> loadMyMotivasyonTextData() async {
  String jsonData = await _loadJsonData();
  final Map<String, dynamic> parsedJson = json.decode(jsonData);

  return MyMotivasyonTextData.fromJson(parsedJson);
}
