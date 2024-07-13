import 'package:safebump/src/network/data/baby/baby_reference.dart';
import 'package:safebump/src/network/data/baby/baby_repo.dart';
import 'package:safebump/src/network/model/baby/baby.dart';
import 'package:safebump/src/network/model/common/result.dart';

class BabyRepositoryImpl extends BabyRepository {
  final babyRef = BabyReference();

  @override
  Future<MResult<MBaby>> getOrAddBaby(MBaby baby) {
    return babyRef.getOrAddBaby(baby);
  }

  @override
  Future<MResult<List<MBaby>>> getBabies() {
    return babyRef.getBabies();
  }
}
