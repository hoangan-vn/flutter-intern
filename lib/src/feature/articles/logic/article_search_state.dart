import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:safebump/src/network/model/articles/articles.dart';

enum ArticlesStatus { init, loading, success, fail }

class ArticlesSearchState with EquatableMixin {
  ArticlesSearchState(
      {this.status = ArticlesStatus.init,
      this.isExpand = false,
      this.articles,
      this.listImage,
      this.searchText,
      this.listSelectedTags,
      this.tags,
      this.listSearchedArticles,
      this.listSearchedImage});

  final ArticlesStatus status;
  final List<MArticles>? articles;
  final Map<String, Uint8List>? listImage;
  final String? searchText;
  final List<String>? listSelectedTags;
  final List<String>? tags;
  final List<MArticles>? listSearchedArticles;
  final Map<String, Uint8List>? listSearchedImage;
  final bool isExpand;

  ArticlesSearchState copyWith(
      {ArticlesStatus? status,
      List<MArticles>? articles,
      Map<String, Uint8List>? listImage,
      String? searchText,
      List<String>? listSelectedTags,
      List<String>? tags,
      List<MArticles>? listSearchedArticles,
      Map<String, Uint8List>? listSearchedImage,
      bool? isExpand}) {
    return ArticlesSearchState(
        status: status ?? this.status,
        articles: articles ?? this.articles,
        listImage: listImage ?? this.listImage,
        searchText: searchText ?? this.searchText,
        listSelectedTags: listSelectedTags ?? this.listSelectedTags,
        tags: tags ?? this.tags,
        listSearchedArticles: listSearchedArticles ?? this.listSearchedArticles,
        listSearchedImage: listSearchedImage ?? this.listSearchedImage,
        isExpand: isExpand ?? this.isExpand);
  }

  @override
  List<Object?> get props => [
        status,
        articles,
        listImage,
        searchText,
        listSelectedTags,
        tags,
        listSearchedArticles,
        listSearchedImage,
        isExpand
      ];
}
