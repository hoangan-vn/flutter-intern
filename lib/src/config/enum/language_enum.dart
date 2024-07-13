enum LanguageEnum {
  english;

  String getText() {
    switch (this) {
      case LanguageEnum.english:
        return 'english';
    }
  }

  static LanguageEnum getLanguage(String language) {
    switch (language) {
      case 'english':
      default:
        return LanguageEnum.english;
    }
  }
}
