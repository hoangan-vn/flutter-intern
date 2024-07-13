import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/string_utils.dart';

enum ImageType { none, network, assest, file, memory }

class XAvatar extends StatefulWidget {
  final String? url;
  final ImageType imageType;
  final bool isEditable;
  final String? name;
  final Uint8List? memoryData;
  final VoidCallback? onEdit;
  final TextStyle? textStyle;
  final double? borderWidth;
  final double? imageSize;
  const XAvatar({
    Key? key,
    this.url,
    this.isEditable = false,
    this.onEdit,
    this.imageType = ImageType.network,
    this.textStyle,
    this.memoryData,
    this.name,
    this.borderWidth,
    this.imageSize,
  }) : super(key: key);

  @override
  State<XAvatar> createState() => _XAvatarState();
}

class _XAvatarState extends State<XAvatar> {
  ImageType _imageType = ImageType.none;

  @override
  void initState() {
    _imageType = widget.imageType;
    super.initState();
  }

  bool isValidUrl(String? url) {
    if (url?.isEmpty ?? true) {
      return false;
    }
    return true;
  }

  String getNameAvatar(String? name) {
    String nameAvatar = '';
    if (!StringUtils.isNullOrEmpty(name)) {
      for (String text in name!.split(' ')) {
        nameAvatar = nameAvatar.padRight(nameAvatar.length + 1, text[0]);
      }
    }
    return nameAvatar.toUpperCase();
  }

  Widget _renderImage(ImageType type) {
    if (widget.memoryData == null) return _renderDefaultImage();
    switch (type) {
      case ImageType.memory:
        return _renderMemoryImage(widget.memoryData ?? Uint8List(0));
      default:
        return _renderDefaultImage();
    }
  }

  Widget _renderDefaultImage() {
    return Container(
        width: widget.imageSize ?? AppSize.s70,
        height: widget.imageSize ?? AppSize.s70,
        decoration: BoxDecoration(
          color: AppColors.subPrimary,
          image: null,
          borderRadius: BorderRadius.all(
            Radius.circular((widget.imageSize ?? AppSize.s70) / 2),
          ),
          border: Border.all(
            color: AppColors.primary,
            width: widget.borderWidth ?? AppSize.s4,
          ),
        ),
        child: Center(
          child: Text(
            getNameAvatar(widget.name),
            style: widget.textStyle ??
                TextStyle(
                  fontFamily: FontFamily.productSans,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontSize: (widget.imageSize ?? AppSize.s70) / 2.5,
                ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _renderImage(_imageType),
        widget.isEditable
            ? Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.p5),
                  decoration: BoxDecoration(
                      color: AppColors.greenLight,
                      borderRadius: BorderRadius.circular(AppRadius.r20)),
                  child: IconButton(
                    onPressed: () {
                      widget.onEdit?.call();
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      minimumSize: MaterialStateProperty.all(Size.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      iconColor: MaterialStateProperty.all(AppColors.white),
                      foregroundColor:
                          MaterialStateProperty.all(AppColors.white),
                    ),
                    icon: Assets.svg.icEdit.svg(
                        width: AppSize.s16,
                        colorFilter: const ColorFilter.mode(
                            AppColors.white, BlendMode.srcIn)),
                    color: AppColors.white,
                    alignment: Alignment.bottomRight,
                    constraints: const BoxConstraints(
                      minWidth: AppSize.s20,
                      minHeight: AppSize.s20,
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _renderMemoryImage(Uint8List memoryData) {
    return Container(
      width: widget.imageSize ?? AppSize.s70,
      height: widget.imageSize ?? AppSize.s70,
      decoration: BoxDecoration(
        color: AppColors.subPrimary,
        image: DecorationImage(
          image: MemoryImage(memoryData),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) async {
            await Future.delayed(const Duration(milliseconds: 500));
            if (mounted) {
              setState(() {
                _imageType = ImageType.none;
              });
            }
          },
        ),
        borderRadius: BorderRadius.all(
          Radius.circular((widget.imageSize ?? AppSize.s70) / 2),
        ),
        border: Border.all(
          color: AppColors.primary,
          width: widget.borderWidth ?? AppSize.s4,
        ),
      ),
      child: null,
    );
  }
}
