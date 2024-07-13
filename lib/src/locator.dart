import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/firebase_options.dart';
import 'package:safebump/src/config/device/app_info.dart';
import 'package:safebump/src/local/repo/articles/article_local_repo.dart';
import 'package:safebump/src/local/repo/articles/article_local_repo_impl.dart';
import 'package:safebump/src/local/repo/baby_infor_fact/baby_infor_fact_local_repo.dart';
import 'package:safebump/src/local/repo/baby_infor_fact/baby_infor_fact_local_repo_impl.dart';
import 'package:safebump/src/local/repo/notes/notes_local_repo.dart';
import 'package:safebump/src/local/repo/notes/notes_local_repo_impl.dart';
import 'package:safebump/src/network/data/articles/articles_repository.dart';
import 'package:safebump/src/network/data/articles/articles_repository_impl.dart';
import 'package:safebump/src/network/data/baby_infor/baby_infor_repository.dart';
import 'package:safebump/src/network/data/baby_infor/baby_infor_repository_impl.dart';
import 'package:safebump/src/network/data/daily_quiz/daily_quiz_repository.dart';
import 'package:safebump/src/network/data/daily_quiz/daily_quiz_repository_impl.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/local/repo/baby_infor_local_repo.dart';
import 'package:safebump/src/local/repo/baby_infor_local_repo_impl.dart';
import 'package:safebump/src/network/data/baby/baby_repo.dart';
import 'package:safebump/src/network/data/baby/baby_repo_impl.dart';
import 'package:safebump/src/network/data/medication/medication_repository.dart';
import 'package:safebump/src/network/data/medication/medication_repository_impl.dart';
import 'package:safebump/src/network/data/note/note_repository.dart';
import 'package:safebump/src/network/data/note/note_repository_impl.dart';
import 'package:safebump/src/network/data/quiz/quiz_repository.dart';
import 'package:safebump/src/network/data/quiz/quiz_repository_impl.dart';
import 'package:safebump/src/network/data/sign/sign_repository.dart';
import 'package:safebump/src/network/data/sign/sign_repository_impl.dart';
import 'package:safebump/src/network/data/user/user_repository.dart';
import 'package:safebump/src/network/data/user/user_repository_impl.dart';
import 'package:safebump/src/network/data/video/video_repository.dart';
import 'package:safebump/src/network/data/video/video_repository_impl.dart';
import 'package:safebump/src/router/router.dart';
import 'package:safebump/src/services/firebase_message.dart';
import 'package:safebump/src/services/user_prefs.dart';

Future initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // catch error
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await Future.wait([
    AppInfo.initialize(),
    UserPrefs.instance.initialize(),
    XFirebaseMessage.instance.initialize(),
    AndroidAlarmManager.initialize(),
  ]);
  _locator();
}

void _locator() {
  GetIt.I.registerLazySingleton(() => AppRouter());

  GetIt.I.registerLazySingleton<SignRepository>(() => SignRepositoryImpl());
  GetIt.I.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  GetIt.I.registerLazySingleton<DailyQuizRepository>(
      () => DailyQuizRepositoryImpl());
  GetIt.I.registerLazySingleton<BabyRepository>(() => BabyRepositoryImpl());
  GetIt.I.registerLazySingleton<NoteRepository>(() => NoteRepositoryImpl());
  GetIt.I.registerLazySingleton<ArticlesRepository>(
      () => ArticlesRepositoryImpl());
  GetIt.I.registerLazySingleton<VideosRepository>(() => VideosRepositoryImpl());
  GetIt.I.registerLazySingleton<QuizRepository>(() => QuizRepositoryImpl());
  GetIt.I.registerLazySingleton<MedicationRepository>(
      () => MedicationRepositoryImpl());
  GetIt.I.registerLazySingleton<BabyInforRepository>(
      () => BabyInforRepositoryImpl());

  GetIt.I.registerLazySingleton<DatabaseApp>((() => DatabaseApp()));
  GetIt.I.registerLazySingleton<BabyInforLocalRepo>(
      () => BabyInforLocalRepoImpl(GetIt.I()));
  GetIt.I.registerLazySingleton<NotesLocalRepo>(
      () => NotesLocalRepoImpl(GetIt.I()));
  GetIt.I.registerLazySingleton<ArticlesLocalRepo>(
      () => ArticlesLocalRepoImpl(GetIt.I()));
  GetIt.I.registerLazySingleton<BabyInforFactLocalRepo>(
      () => BabyInforFactLocalRepoImpl(GetIt.I()));
}

void resetSingleton() {
  GetIt.I.resetLazySingleton<MedicationRepository>();
  GetIt.I.resetLazySingleton<BabyRepository>();
  GetIt.I.resetLazySingleton<NoteRepository>();
}

void reRegisterSingleton() {
  GetIt.I.registerLazySingleton<BabyRepository>(() => BabyRepositoryImpl());
  GetIt.I.registerLazySingleton<NoteRepository>(() => NoteRepositoryImpl());
}
