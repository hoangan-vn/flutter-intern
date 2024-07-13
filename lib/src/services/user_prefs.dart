import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safebump/src/config/enum/language_enum.dart';
import 'package:safebump/src/feature/edit_profile/widget/unit_segment.dart';
import 'package:safebump/src/network/model/user/user.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class _keys {
  static const String theme = 'app-theme';
  static const String user = 'user';
  static const String token = 'token';
  static const String pergnancyDay = 'pergnancyDay';
  static const String firstOpen = 'firstOpen';
  static const String doDailyQuiz = 'doDailyQuiz';
  static const String isUserCorrect = 'isUserCorrect';
  static const String percentCorrectDailyQuiz = 'percentCorrectDailyQuiz';
  static const String bodyMeasurementUnitType = 'bodyMeasurementUnitType';
  static const String language = 'language';
  static const String selectedQuizId = "selectedQuizId";
  static const String userAvatar = "userAvatar";
}

class UserPrefs {
  factory UserPrefs() => instance;
  UserPrefs._internal();

  static final UserPrefs instance = UserPrefs._internal();
  static UserPrefs get I => instance;
  late SharedPreferences _prefs;
  Future initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> clearSharedPref() async {
    await setToken(null);
    await setUser(null);
    await setDoDailyQuiz(false);
    await setLanguage(LanguageEnum.english);
    await setPercentCorrectDailyQuiz(0);
    await setPergnancyDay(DateTime.now());
  }

  // theme
  ThemeMode getTheme() {
    final value = _prefs.getString(_keys.theme);
    return ThemeMode.values.firstWhere(
      (e) => e.toString().toLowerCase() == '$value'.toLowerCase(),
      orElse: () => ThemeMode.system,
    );
  }

  void setTheme(ThemeMode value) {
    _prefs.setString(_keys.theme, value.toString().toLowerCase());
  }

  String getToken() {
    try {
      return _prefs.getString(_keys.token) ?? '';
    } catch (_) {}
    return '';
  }

  Future<void> setToken(String? value) async {
    if (value == null) {
      await _prefs.remove(_keys.token);
    } else {
      await _prefs.setString(_keys.token, value);
    }
  }

  // user
  Future<void> setUser(MUser? value) async {
    if (value == null) {
      await _prefs.remove(_keys.user);
    } else {
      await _prefs.setString(_keys.user, jsonEncode(value.toJson()));
    }
  }

  MUser? getUser() {
    final value = _prefs.getString(_keys.user);
    try {
      if ((value ?? '').isEmpty) {
        return null;
      } else {
        final map = jsonDecode(value!);
        if (map['id'] == null) {
          return null;
        } else {
          return MUser.fromJson(map);
        }
      }
    } catch (e) {
      xLog.e(e);
      return null;
    }
  }

  DateTime getPergnancyDay() {
    try {
      final pergnancyDayStr = _prefs.getString(_keys.pergnancyDay);
      if (!StringUtils.isNullOrEmpty(pergnancyDayStr)) {
        return DateFormat("y/M/d").parse(pergnancyDayStr!);
      }
      return DateTime.now();
    } catch (e) {
      xLog.e(e);
      return DateTime.now();
    }
  }

  Future<void> setPergnancyDay(DateTime date) async {
    await _prefs.setString(
        _keys.pergnancyDay, DateFormat("y/M/d").format(date));
  }

  //First open App
  bool getIsFirstOpenApp() {
    try {
      final isFirst = _prefs.getBool(_keys.firstOpen);
      if (isFirst == null) return true;
      return isFirst;
    } catch (e) {
      xLog.e(e);
      return true;
    }
  }

  Future<void> setIsFirstOpenApp(bool isFirst) async {
    await _prefs.setBool(_keys.firstOpen, isFirst);
  }

  bool getDoDailyQuiz() {
    try {
      return _prefs.getBool(_keys.doDailyQuiz) ?? false;
    } catch (_) {}
    return false;
  }

  Future<void> setDoDailyQuiz(bool isAnswer) async {
    await _prefs.setBool(_keys.doDailyQuiz, isAnswer);
  }

  bool getIsUserCorrect() {
    try {
      return _prefs.getBool(_keys.isUserCorrect) ?? false;
    } catch (_) {}
    return false;
  }

  Future<void> setIsUserCorrect(bool isCorrect) async {
    await _prefs.setBool(_keys.isUserCorrect, isCorrect);
  }

  int getPercentCorrectDailyQuiz() {
    try {
      return _prefs.getInt(_keys.percentCorrectDailyQuiz) ?? 0;
    } catch (_) {}
    return 0;
  }

  Future<void> setPercentCorrectDailyQuiz(int percent) async {
    await _prefs.setInt(_keys.percentCorrectDailyQuiz, percent);
  }

  MeasurementUnitType getBodyMeasurementUnitType() {
    try {
      return MeasurementUnitType.getType(
          _prefs.getString(_keys.bodyMeasurementUnitType) ?? '');
    } catch (_) {}
    return MeasurementUnitType.metric;
  }

  Future<void> setBodyMeasurementUnitType(MeasurementUnitType type) async {
    await _prefs.setString(_keys.bodyMeasurementUnitType, type.getText());
  }

  LanguageEnum getLanguage() {
    try {
      return LanguageEnum.getLanguage(_prefs.getString(_keys.language) ?? '');
    } catch (_) {}
    return LanguageEnum.english;
  }

  Future<void> setLanguage(LanguageEnum language) async {
    await _prefs.setString(_keys.language, language.getText());
  }

  String getSelectedQuizId() {
    try {
      return _prefs.getString(_keys.selectedQuizId) ?? '';
    } catch (_) {}
    return '';
  }

  Future<void> setSelectedQuizId(String id) async {
    await _prefs.setString(_keys.selectedQuizId, id);
  }

  Uint8List getUserAvatar() {
    try {
      final userPref = _prefs.getStringList(_keys.userAvatar) ?? [];
      List<int> data = userPref.map((e) => int.parse(e)).toList();
      return Uint8List.fromList(data);
    } catch (_) {}
    return Uint8List(0);
  }

  Future<void> setUserAvatar(Uint8List avatar) async {
    await _prefs.setStringList(_keys.userAvatar,
        avatar.toList().map((e) => e.toString()).toList());
  }
}
