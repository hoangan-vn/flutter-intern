import 'package:flutter/foundation.dart';
import 'package:safebump/src/network/model/baby_infor/baby_infor.dart';

enum PregnancyTrackerStatus { init, loading, fail, success }

class PregnancyTrackerState {
  PregnancyTrackerState(
      {this.status = PregnancyTrackerStatus.init,
      required this.selectedWeek,
      this.babyInforImage,
      this.babyInfor});

  final int selectedWeek;
  final PregnancyTrackerStatus status;
  final MBabyInfor? babyInfor;
  final Uint8List? babyInforImage;

  PregnancyTrackerState copyWith({
    int? selectedWeek,
    PregnancyTrackerStatus? status,
    MBabyInfor? babyInfor,
    Uint8List? babyInforImage,
  }) {
    return PregnancyTrackerState(
      selectedWeek: selectedWeek ?? this.selectedWeek,
      status: status ?? this.status,
      babyInfor: babyInfor ?? this.babyInfor,
      babyInforImage: babyInforImage ?? this.babyInforImage,
    );
  }
}
