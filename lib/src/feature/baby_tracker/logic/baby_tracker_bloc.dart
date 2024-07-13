import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/baby_tracker/logic/baby_tracker_state.dart';
import 'package:safebump/src/local/repo/baby_infor_fact/baby_infor_fact_local_repo.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/model/baby_infor/baby_infor.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/src/utils/utils.dart';

class PregnancyTrackerBloc extends Cubit<PregnancyTrackerState> {
  PregnancyTrackerBloc(int week)
      : super(PregnancyTrackerState(selectedWeek: week));

  Future<void> inital() async {
    _createLoadingScreen();
    await _initBabyInforData(state.selectedWeek);
    _hideLoadingScreen();
  }

  void _createLoadingScreen() {
    emit(state.copyWith(status: PregnancyTrackerStatus.loading));
    XToast.showLoading();
  }

  void _hideLoadingScreen() {
    if (XToast.isShowLoading) {
      XToast.hideLoading();
    }
  }

  Future<void> _initBabyInforData(int selectedWeek) async {
    try {
      final result = await GetIt.I
          .get<BabyInforFactLocalRepo>()
          .getDetailFollowWeek(week: selectedWeek)
          .get();
      //Handle empty data
      if (isNullOrEmpty(result)) {
        XToast.error(S.text.someThingWentWrong);
        return;
      }
      final babyInfor = BabyInforExt.convertFromEntityData(result);
      final babyInforImage = result.first.image;
      emit(state.copyWith(
          babyInfor: babyInfor.first,
          babyInforImage: babyInforImage,
          status: PregnancyTrackerStatus.success));
    } catch (e) {
      xLog.e(e);
    }
  }

  Future<void> onChangeWeek(int week) async {
    if (state.selectedWeek == week) return;
    emit(state.copyWith(selectedWeek: week));
    _createLoadingScreen();
    await Future.delayed(const Duration(milliseconds: 500));
    await _initBabyInforData(week);
    _hideLoadingScreen();
  }

  List<String> splitContentToParagraph(String? data) {
    if (StringUtils.isNullOrEmpty(data)) return [];
    return data!.split('  ').toList();
  }
}
