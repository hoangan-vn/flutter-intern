import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/utils/utils.dart';

class BaseStorageReference<T> {
  BaseStorageReference(this.ref, this.subRef);

  void log(dynamic value) => debugPrint('$value');
  final Reference ref;
  final Reference? subRef;

  Future<MResult<Uint8List>> get(String item,
      {bool isGetFromSubRef = false}) async {
    final itemRef = isGetFromSubRef && subRef != null
        ? subRef!.child(item)
        : ref.child(item);
    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await itemRef.getData(oneMegabyte);
      return MResult.success(data);
    } on FirebaseException catch (e) {
      xLog.e(e.message);
      return MResult.exception(e);
    }
  }

  Future<MResult<String>> getUrl(String item,
      {bool isGetFromSubRef = false}) async {
    final itemRef = isGetFromSubRef && subRef != null
        ? subRef!.child(item)
        : ref.child(item);
    try {
      final String data = await itemRef.getDownloadURL();
      return MResult.success(data);
    } on FirebaseException catch (e) {
      xLog.e(e.message);
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> delete(String item) async {
    try {
      await ref.child(item).delete().timeout(const Duration(seconds: 5));
      return MResult.success(true);
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }

  Future<MResult<List>> getAll({bool isGetFromSubRef = false}) async {
    try {
      final ListResult listAll = isGetFromSubRef && subRef != null
          ? await subRef!.listAll().timeout(const Duration(seconds: 5))
          : await ref.listAll().timeout(const Duration(seconds: 5));

      return MResult.success([listAll.items, listAll.prefixes]);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> add(String item, Uint8List data) async {
    final itemRef = ref.child(item);
    try {
      itemRef.putData(data, SettableMetadata(contentType: 'image/jpeg'));
      return MResult.success(true);
    } on FirebaseException catch (e) {
      xLog.e(e.message);
      return MResult.exception(e);
    }
  }
}
