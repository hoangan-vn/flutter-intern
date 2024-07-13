import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/add_baby/logic/state/add_fetus_state.dart';
import 'package:safebump/src/local/model/baby_infor.dart';
import 'package:safebump/src/local/repo/baby_infor_local_repo.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/data/baby/baby_repo.dart';
import 'package:safebump/src/network/model/baby/baby.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/services/user_prefs.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/src/utils/utils.dart';

class AddFetusBloc extends Cubit<AddFetusState> {
  AddFetusBloc() : super(AddFetusState());

  void onChangedFetusName(String name) {
    emit(state.copyWith(fetusName: name, errorFetusName: ''));
  }

  void onChangedFetusDueDate(DateTime dueDate) {
    emit(state.copyWith(fetusDueDate: dueDate, errorFetusDueDate: ''));
  }

  void onChangedFetusPicture(String imagePath) {
    emit(state.copyWith(fetusImage: imagePath));
  }

  Future<void> saveFetusInfor() async {
    if (state.status == AddFetusScreenStatus.saving) return;
    if (_checkInvalidInforData()) {
      emit(state.copyWith(status: AddFetusScreenStatus.fail));
      return;
    }
    emit(state.copyWith(status: AddFetusScreenStatus.saving));
    final idGenerate = StringUtils.createGenerateRandomText(length: 16);
    final fetus = BabyInforModel(
        id: idGenerate,
        name: state.fetusName,
        type: state.type.getBabyTypeText(),
        date: state.fetusDueDate!);
    try {
      await GetIt.I
          .get<BabyInforLocalRepo>()
          .insertDetail(<BabyInforModel>[fetus].toListBabyInforEntity().first);
      final result = await GetIt.I.get<BabyRepository>().getOrAddBaby(MBaby(
          id: idGenerate,
          name: fetus.name,
          type: fetus.type,
          date: fetus.date));
      if (result.data != null) {
        emit(state.copyWith(status: AddFetusScreenStatus.success));
        xLog.e(state.fetusDueDate);
        UserPrefs.I.setPergnancyDay(state.fetusDueDate ?? DateTime.now());
        AppCoordinator.pop();
        AppCoordinator.pop(true);
      }
    } catch (e) {
      xLog.e(e);
      XToast.error(S.text.someThingWentWrong);
      emit(state.copyWith(status: AddFetusScreenStatus.fail));
    }
  }

  bool _checkInvalidInforData() {
    bool isInvalidName = _checkInvalidName(state.fetusName);
    bool isInvalidDueDate = _checkInvalidDueDate(state.fetusDueDate);
    return isInvalidName && isInvalidDueDate;
  }

  bool _checkInvalidName(String fetusName) {
    if (StringUtils.isNullOrEmpty(fetusName)) {
      emit(state.copyWith(errorFetusName: S.text.thisFieldIsNotEmpty));
      return true;
    }
    return false;
  }

  bool _checkInvalidDueDate(DateTime? fetusDueDate) {
    if (fetusDueDate == null) {
      emit(state.copyWith(errorFetusDueDate: S.text.thisFieldIsNotEmpty));
      return true;
    }
    return false;
  }
}
