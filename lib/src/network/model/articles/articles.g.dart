// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MArticles _$MArticlesFromJson(Map<String, dynamic> json) => MArticles(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      summarize: json['summarize'] as String,
      author: json['author'] as String,
      link: json['link'] as String,
      tag: (json['tag'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MArticlesToJson(MArticles instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'summarize': instance.summarize,
      'author': instance.author,
      'link': instance.link,
      'tag': instance.tag,
    };
