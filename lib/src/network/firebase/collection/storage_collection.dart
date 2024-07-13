import 'package:firebase_storage/firebase_storage.dart';

class XStorageCollection {
  static Reference get articles =>
      FirebaseStorage.instance.ref().child('articles');

  static Reference get video => FirebaseStorage.instance.ref().child('videos');
  static Reference get videoThumbnail =>
      FirebaseStorage.instance.ref().child('videos/images');
  static Reference get users => FirebaseStorage.instance.ref().child('user');
  static Reference get babyInfor =>
      FirebaseStorage.instance.ref().child('baby_infor');
}
