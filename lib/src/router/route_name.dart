enum AppRouteNames {
  home(path: '/'),
  onBoarding(path: '/onBoarding'),
  signIn(path: '/signIn'),
  signUp(path: '/signUp'),
  syncData(path: '/syncData'),
  dashboard(path: '/dashboard'),
  calendar(path: '/calendar'),
  profile(path: '/profile'),
  medicineProfile(path: '/medicineProfile'),
  enterMail(path: '/enterMail'),
  verifyCode(path: 'verifyCode', param: "mail"),
  resetPassword(path: '/resetPassword'),
  optionAddBaby(path: '/optionAddBaby'),
  addBaby(path: '/addBaby'),
  babyTracker(path: 'babyTracker', param: "week"),
  addPregnancyBaby(path: '/addPregnancyBaby'),
  articles(path: '/articles'),
  articlesSearch(path: '/articlesSearch'),
  articlesDetail(path: 'articlesDetail', param: 'id'),
  videos(path: '/videos'),
  editProfile(path: '/editProfile'),
  setting(path: '/setting'),
  aboutApp(path: '/aboutApp'),
  quiz(path: '/quiz'),
  questionQuiz(path: 'questionQuiz', param: 'id'),
  medication(path: '/medication'),
  addMedication(path: '/addMedication');

  const AppRouteNames({
    required this.path,
    this.param,
  });

  final String path;
  final String? param;

  String get name => path;

  String get subPath {
    if (path == '/') {
      return path;
    }
    return path.replaceFirst('/', '');
  }

  String get buildPathParam => '$path:$param';
  String get buildSubPathParam => '$subPath:$param';
}
