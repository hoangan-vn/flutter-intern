import 'package:safebump/src/network/model/baby/baby.dart';
import 'package:safebump/src/network/model/common/result.dart';

abstract class BabyRepository {
  // Future<MResult<MBaby>> getBaby();
  Future<MResult<MBaby>> getOrAddBaby(MBaby baby);
  Future<MResult<List<MBaby>>> getBabies();
}
