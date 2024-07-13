import 'package:safebump/src/localization/localization_utils.dart';

enum DoseType {
  application,
  cap,
  drop,
  gram,
  injection,
  miligram,
  mililiter,
  packet,
  patch,
  piece,
  pill,
  puff,
  spoon,
  spray,
  suppository,
  unit;

  String getText() {
    switch (this) {
      case DoseType.application:
        return S.text.application;
      case DoseType.cap:
        return S.text.cap;
      case DoseType.drop:
        return S.text.drop;
      case DoseType.gram:
        return S.text.gram;
      case DoseType.injection:
        return S.text.injection;
      case DoseType.miligram:
        return S.text.miligram;
      case DoseType.mililiter:
        return S.text.mililiter;
      case DoseType.packet:
        return S.text.packet;
      case DoseType.patch:
        return S.text.patch;
      case DoseType.piece:
        return S.text.piece;
      case DoseType.pill:
        return S.text.pill;
      case DoseType.puff:
        return S.text.puff;
      case DoseType.spoon:
        return S.text.spoon;
      case DoseType.spray:
        return S.text.spray;
      case DoseType.suppository:
        return S.text.suppository;
      case DoseType.unit:
        return S.text.unit;
    }
  }

  static DoseType gettype(String type) {
    switch (type) {
      case 'Application':
        return DoseType.application;
      case 'Cap':
        return DoseType.cap;
      case 'Drop':
        return DoseType.drop;
      case 'Gram':
        return DoseType.gram;
      case 'Injection':
        return DoseType.injection;
      case 'Miligram':
        return DoseType.miligram;
      case 'Mililiter':
        return DoseType.mililiter;
      case 'Packet':
        return DoseType.packet;
      case 'Patch':
        return DoseType.patch;
      case 'Piece':
        return DoseType.piece;
      case 'Pill':
        return DoseType.pill;
      case 'Puff':
        return DoseType.puff;
      case 'Spoon':
        return DoseType.spoon;
      case 'Spray':
        return DoseType.spray;
      case 'Suppository':
        return DoseType.suppository;
      case 'Unit':
      default:
        return DoseType.unit;
    }
  }
}

enum ReminderFrequencyEnum {
  everyDay;

  String get getValue {
    switch (this) {
      case ReminderFrequencyEnum.everyDay:
        return S.text.everyDay;
    }
  }

  int get getIntValue {
    switch (this) {
      case ReminderFrequencyEnum.everyDay:
        return 1;
    }
  }
}
