import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:safebump/src/local/database_app.dart';

part 'articles.g.dart';

@JsonSerializable(explicitToJson: true)
class MArticles {
  MArticles(
      {required this.id,
      required this.title,
      required this.content,
      required this.summarize,
      required this.author,
      required this.link,
      required this.tag});

  String id;
  String title;
  String content;
  String summarize;
  String author;
  String link;
  List<String> tag;
  MArticles copyWith(
      {String? id,
      String? title,
      String? content,
      String? summarize,
      String? author,
      String? link,
      List<String>? tag}) {
    return MArticles(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        summarize: summarize ?? this.summarize,
        author: author ?? this.author,
        link: link ?? this.link,
        tag: tag ?? this.tag);
  }

  Map<String, dynamic> toJson() => _$MArticlesToJson(this);

  factory MArticles.fromJson(Map<String, dynamic> json) =>
      _$MArticlesFromJson(json);

  @override
  String toString() {
    return 'MArticles{id=$id, title=$title, content=$content, summarize=$summarize, author=$author, link=$link, tag=$tag}';
  }
}

extension ArticlesExt on List<MArticles> {
  List<ArticlesEntityData> convertToEntityData() {
    List<ArticlesEntityData> listData = [];
    for (MArticles data in this) {
      final dataJson = data.toJson();
      dataJson['tag'] = data.tag.join(',');
      listData.add(ArticlesEntityData.fromJson(dataJson));
    }
    return listData;
  }

  static List<MArticles> convertFromEntityData(
      List<ArticlesEntityData> listDataEntity) {
    List<MArticles> listData = [];
    for (ArticlesEntityData data in listDataEntity) {
      final dataJson = data.toJson();
      dataJson['tag'] = (dataJson['tag'] as String)
          .split(',')
          .map<String>((e) => e.trim())
          .toList();
      listData.add(MArticles.fromJson(dataJson));
    }
    return listData;
  }

  static Map<String, Uint8List> getListImage(
      List<ArticlesEntityData> listDataEntity) {
    Map<String, Uint8List> images = {};
    for (ArticlesEntityData data in listDataEntity) {
      final dataJson = data.toJson();
      List<String> imageLocalData = (dataJson['image'] as String)
          .split(',')
          .map<String>((e) => e.trim())
          .toList();
      List<int> imageData =
          imageLocalData.map<int>((e) => int.parse(e)).toList();
      images.addEntries({data.id: Uint8List.fromList(imageData)}.entries);
    }
    return images;
  }

  static String getImageString(Uint8List imagesData) {
    List<String> listImagesStringData =
        imagesData.toList().map((e) => e.toString()).toList();
    return listImagesStringData.join(',');
  }
}
