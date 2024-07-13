import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:safebump/src/router/route_name.dart';

import 'router.dart';

class AppCoordinator {
  static AppRouter get rootRouter => GetIt.I<AppRouter>();
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final shellKey = GlobalKey<NavigatorState>();
  static BuildContext get context => navigatorKey.currentState!.context;

  static void pop<T extends Object?>([T? result]) => context.pop(result);

  static void goNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) =>
      context.goNamed(
        name,
        pathParameters: params,
        queryParameters: queryParams,
        extra: extra,
      );

  static void showHomeScreen() => context.goNamed(AppRouteNames.home.name);

  static void showSignInScreen() =>
      context.pushReplacementNamed(AppRouteNames.signIn.name);

  static void showSignUpScreen() =>
      context.pushNamed(AppRouteNames.signUp.name);

  static void showEnterMailScreen() =>
      context.pushNamed(AppRouteNames.enterMail.name);

  static void showVerifyCodeScreen(String mail) => context
      .pushNamed(AppRouteNames.verifyCode.name, pathParameters: {'mail': mail});

  static void showResetPasswordScreen() =>
      context.pushReplacementNamed(AppRouteNames.resetPassword.name);

  static void showAddBabyScreen() =>
      context.pushNamed(AppRouteNames.addBaby.name);

  static void showAddPregnancyBabyScreen() =>
      context.pushNamed(AppRouteNames.addPregnancyBaby.name);

  static Future<bool> showOptionsAddBaby() async => await context
      .pushNamed<bool>(AppRouteNames.optionAddBaby.name)
      .then((value) => value ?? false);
  static void showSyncDataScreen() =>
      context.pushReplacementNamed(AppRouteNames.syncData.name);

  static void showExtensionScreen(String routeName) =>
      context.pushNamed(routeName);

  static Future<bool> showEditProfileScreen() async {
    bool result = false;
    await context
        .pushNamed<bool>(AppRouteNames.editProfile.name)
        .then((value) => result = value ?? false);
    return result;
  }

  static void showAboutScreen() =>
      context.pushNamed(AppRouteNames.aboutApp.name);
  static void showSettingScreen() =>
      context.pushNamed(AppRouteNames.setting.name);

  static void showArticleDetailScreen(String id) => context
      .pushNamed(AppRouteNames.articlesDetail.name, pathParameters: {'id': id});

  static void showQuestionQuizScreen(String title) =>
      context.pushNamed(AppRouteNames.questionQuiz.name,
          pathParameters: {'id': title});

  static Future<bool> showAddMedication() async {
    bool result = false;
    await context
        .pushNamed<bool>(AppRouteNames.addMedication.name)
        .then((value) => result = value ?? false);
    return result;
  }

  static void showArticlesSearchScreen() =>
      context.pushNamed(AppRouteNames.articlesSearch.name);

  static void showBabyTrackerScreen(String week) =>
      context.pushNamed(AppRouteNames.babyTracker.name,
          pathParameters: {'week': week});
}
