import 'dart:convert';

import 'package:flutter/services.dart';

class MyTheme {
  final String imgUrl;
  final String name;
  final String aciklama;
  final String photoAciklama;

  MyTheme(
      {required this.imgUrl,
      required this.name,
      required this.aciklama,
      required this.photoAciklama});

  factory MyTheme.fromJson(Map<String, dynamic> json) {
    return MyTheme(
      imgUrl: json['imgUrl'],
      name: json['name'],
      aciklama: json['aciklama'],
      photoAciklama: json['photoAciklama'],
    );
  }
}

class MyData {
  final List<MyTheme> tema;
  final List<MyTheme> canli;
  final List<MyTheme> sesler;
  final List<MyTheme> kategori;

  MyData({
    required this.tema,
    required this.canli,
    required this.sesler,
    required this.kategori,
  });

  factory MyData.fromJson(Map<String, dynamic> json) {
    List<dynamic> temaList = json['tema'];
    List<dynamic> canliList = json['canli'];
    List<dynamic> seslerList = json['sesler'];
    List<dynamic> kategoriList = json['kategori'];

    List<MyTheme> tema =
        temaList.map((item) => MyTheme.fromJson(item)).toList();
    List<MyTheme> canli =
        canliList.map((item) => MyTheme.fromJson(item)).toList();
    List<MyTheme> sesler =
        seslerList.map((item) => MyTheme.fromJson(item)).toList();
    List<MyTheme> kategori =
        kategoriList.map((item) => MyTheme.fromJson(item)).toList();

    return MyData(tema: tema, canli: canli, sesler: sesler, kategori: kategori);
  }
}

Future<String> _loadJsonData() async {
  return await rootBundle.loadString('assets/json/kategori.json');
}

Future<MyData> loadMyData() async {
  String jsonData = await _loadJsonData();
  final Map<String, dynamic> parsedJson = json.decode(jsonData);

  return MyData.fromJson(parsedJson);
}
