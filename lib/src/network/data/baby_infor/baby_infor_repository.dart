import 'dart:typed_data';

import 'package:safebump/src/network/model/baby_infor/baby_infor.dart';
import 'package:safebump/src/network/model/common/result.dart';

abstract class BabyInforRepository {
  Future<MResult<List<MBabyInfor>>> getAllBabyInfor();

  Future<MResult<MBabyInfor>> getBabyInfor(String id);

  Future<MResult<List>> getAllBabyInforImage();

  Future<MResult<Uint8List>> getBabyInforImage(String id);
}
