import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:safebump/src/network/model/user/user.dart';

enum ProfileScreenStatus { init, loading, fail, success }

class ProfileState with EquatableMixin {
  ProfileState(
      {required this.user,
      this.avatar,
      this.status = ProfileScreenStatus.init});

  final MUser user;
  final Uint8List? avatar;
  final ProfileScreenStatus status;

  ProfileState copyWith(
      {MUser? user, Uint8List? avatar, ProfileScreenStatus? status}) {
    return ProfileState(
        user: user ?? this.user,
        status: status ?? this.status,
        avatar: avatar ?? this.avatar);
  }

  @override
  List<Object?> get props => [user, status, avatar];
}
