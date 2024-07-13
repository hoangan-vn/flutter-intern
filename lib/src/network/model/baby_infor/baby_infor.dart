import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:safebump/src/local/database_app.dart';

part 'baby_infor.g.dart';

@JsonSerializable(explicitToJson: true)
class MBabyInfor {
  MBabyInfor(
      {required this.id,
      required this.week,
      required this.data,
      this.height,
      this.fact,
      this.weight});

  String id;
  int week;
  double? height;
  double? weight;
  Map<String, String> data;
  String? fact;
  MBabyInfor copyWith(
      {String? id,
      int? week,
      double? height,
      double? weight,
      String? fact,
      Map<String, String>? data}) {
    return MBabyInfor(
        id: id ?? this.id,
        week: week ?? this.week,
        fact: fact ?? this.fact,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        data: data ?? this.data);
  }

  @override
  String toString() {
    return 'MBabyInfor{id=$id, week=$week, height=$height, weight=$weight, data=$data, fact=$fact}';
  }

  Map<String, dynamic> toJson() => _$MBabyInforToJson(this);

  factory MBabyInfor.fromJson(Map<String, dynamic> json) =>
      _$MBabyInforFromJson(json);
}

extension BabyInforExt on List<MBabyInfor> {
  List<BabyInforFactEntityData> convertToEntityData() {
    List<BabyInforFactEntityData> listData = [];
    for (MBabyInfor babyData in this) {
      final dataJson = babyData.toJson();
      dataJson.remove('data');
      dataJson.addEntries({
        'yourBaby': babyData.data['Your baby'],
        'yourBody': babyData.data['Your body'],
        'thingsToRemember': babyData.data['Things to remember']
      }.entries);
      listData.add(BabyInforFactEntityData.fromJson(dataJson));
    }
    return listData;
  }

  static List<MBabyInfor> convertFromEntityData(
      List<BabyInforFactEntityData> listDataEntity) {
    List<MBabyInfor> listData = [];
    for (BabyInforFactEntityData data in listDataEntity) {
      listData.add(MBabyInfor(
          id: data.id,
          week: data.week,
          data: {
            'yourBaby': data.yourBaby,
            'yourBody': data.yourBody,
            'thingsToRemember': data.thingsToRemember,
          },
          fact: data.fact,
          height: data.height,
          weight: data.weight));
    }
    return listData;
  }

  static Map<String, Uint8List> getListImage(
      List<BabyInforFactEntityData> listDataEntity) {
    Map<String, Uint8List> images = {};
    for (BabyInforFactEntityData data in listDataEntity) {
      images.addEntries(
          {data.week.toString(): data.image ?? Uint8List(0)}.entries);
    }
    return images;
  }

  static String getImageString(Uint8List imagesData) {
    List<String> listImagesStringData =
        imagesData.toList().map((e) => e.toString()).toList();
    return listImagesStringData.join(',');
  }
}
