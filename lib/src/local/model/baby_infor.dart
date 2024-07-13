import 'package:json_annotation/json_annotation.dart';
import 'package:safebump/src/local/database_app.dart';
part 'baby_infor.g.dart';

@JsonSerializable(explicitToJson: true)
class BabyInforModel {
  String id;
  String name;
  String type;
  DateTime date;
  String? gender;
  double? weight;
  double? height;

  BabyInforModel(
      {required this.id,
      required this.name,
      required this.type,
      required this.date,
      this.height,
      this.gender,
      this.weight});

  factory BabyInforModel.fromJson(Map<String, dynamic> json) =>
      _$BabyInforModelFromJson(json);

  Map<String, dynamic> toJson() => _$BabyInforModelToJson(this);
}

extension BabyInforModelExt on List<BabyInforModel> {
  List<BabyInforEntityData> toListBabyInforEntity() {
    List<BabyInforEntityData> list = [];
    for (BabyInforModel item in this) {
      list.add(BabyInforEntityData(
        date: item.date,
        weight: item.weight,
        height: item.height,
        id: item.id,
        name: item.name,
        type: item.type,
        gender: item.gender,
      ));
    }
    return list;
  }
}
