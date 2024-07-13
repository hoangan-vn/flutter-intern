import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:safebump/src/network/data/user/user_reference.dart';
import 'package:safebump/src/network/data/user/user_reference_storage.dart';
import 'package:safebump/src/network/data/user/user_repository.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/user/user.dart';

class UserRepositoryImpl extends UserRepository {
  final usersRef = UserReference();
  final usersRefStorage = UsersStorageReference();
  @override
  Future<MResult<MUser>> getUser() async {
    try {
      final result = FirebaseAuth.instance.currentUser;
      if (result == null) {
        return MResult.error('Not user login');
      }
      final user =
          MUser(id: result.uid, email: result.email, name: result.displayName);
      return MResult.success(user);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<MUser>> getOrAddUser(MUser user) {
    return usersRef.getOrAddUser(user);
  }

  @override
  Future<MResult<List<MUser>>> getUsers() {
    return usersRef.getUsers();
  }

  @override
  Future<MResult<bool>> upsertUser(MUser user) {
    return usersRef.updateUser(user);
  }

  @override
  Future<MResult<bool>> deleteUser(MUser user) {
    return usersRef.deleteUser(user);
  }

  @override
  Future<MResult<Uint8List>> getImage(String id) async {
    return await usersRefStorage.getUserAvatar(id);
  }

  @override
  Future<MResult<bool>> addImage(String id, Uint8List data) async {
    return await usersRefStorage.upsertUserAvatar(id, data);
  }

  @override
  Future<MResult<bool>> deleteImage(String id) async {
    return await usersRefStorage.deleteUserAvatar(id);
  }
}
