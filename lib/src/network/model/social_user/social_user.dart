import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safebump/src/network/model/social_type.dart';
import 'package:safebump/src/utils/utils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'social_user.freezed.dart';
part 'social_user.g.dart';

@freezed
class MSocialUser with _$MSocialUser {
  const factory MSocialUser({
    required MSocialType type,

    /// Apple userID
    String? userID,

    /// Google Access Token
    String? accessToken,

    /// Google ID Token
    String? idToken,

    /// Google information
    String? fullName,
    String? email,
    String? avatar,
    String? birthDate,
    int? gender,
    String? phone,
  }) = _MSocialUser;

  factory MSocialUser.fromJson(Map<String, Object?> json) =>
      _$MSocialUserFromJson(json);

  factory MSocialUser.fromGoogleAccount(
    GoogleSignInAccount account,
    GoogleSignInAuthentication googleAuth,
  ) {
    return MSocialUser(
      type: MSocialType.google,
      fullName: account.displayName,
      email: account.email,
      avatar: account.photoUrl,
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  }

  factory MSocialUser.fromAppleAccount(
      AuthorizationCredentialAppleID credential) {
    return MSocialUser(
      type: MSocialType.apple,
      userID: credential.userIdentifier,
      fullName: Utils.fullnameOf(credential.givenName, credential.familyName),
      email: credential.email,
    );
  }
}
