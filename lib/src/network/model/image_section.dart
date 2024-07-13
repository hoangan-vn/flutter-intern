import 'dart:typed_data';

class ImageSelection {
  final String name;
  final String type;
  final Uint8List bytes;
  final String path;

  ImageSelection(
      {required this.name,
      required this.type,
      required this.bytes,
      required this.path});
}
