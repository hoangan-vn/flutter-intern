/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesImagesGen get images => const $AssetsImagesImagesGen();
}

class $AssetsJsonsGen {
  const $AssetsJsonsGen();

  /// File path: assets/jsons/sync_data.json
  LottieGenImage get syncData =>
      const LottieGenImage('assets/jsons/sync_data.json');

  /// List of all assets
  List<LottieGenImage> get values => [syncData];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/empty_illustratiom.svg
  SvgGenImage get emptyIllustratiom =>
      const SvgGenImage('assets/svg/empty_illustratiom.svg');

  /// File path: assets/svg/error-in-calendar.svg
  SvgGenImage get errorInCalendar =>
      const SvgGenImage('assets/svg/error-in-calendar.svg');

  /// File path: assets/svg/ic_edit.svg
  SvgGenImage get icEdit => const SvgGenImage('assets/svg/ic_edit.svg');

  /// File path: assets/svg/ic_us.svg
  SvgGenImage get icUs => const SvgGenImage('assets/svg/ic_us.svg');

  /// File path: assets/svg/writer.svg
  SvgGenImage get writer => const SvgGenImage('assets/svg/writer.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [emptyIllustratiom, errorInCalendar, icEdit, icUs, writer];
}

class $AssetsImagesImagesGen {
  const $AssetsImagesImagesGen();

  /// File path: assets/images/images/apple_logo.png
  AssetGenImage get appleLogo =>
      const AssetGenImage('assets/images/images/apple_logo.png');

  /// File path: assets/images/images/gg_logo.png
  AssetGenImage get ggLogo =>
      const AssetGenImage('assets/images/images/gg_logo.png');

  /// File path: assets/images/images/ic_correct.png
  AssetGenImage get icCorrect =>
      const AssetGenImage('assets/images/images/ic_correct.png');

  /// File path: assets/images/images/ic_wrong.png
  AssetGenImage get icWrong =>
      const AssetGenImage('assets/images/images/ic_wrong.png');

  /// File path: assets/images/images/logo.png
  AssetGenImage get logo =>
      const AssetGenImage('assets/images/images/logo.png');

  /// File path: assets/images/images/medicine.png
  AssetGenImage get medicine =>
      const AssetGenImage('assets/images/images/medicine.png');

  /// File path: assets/images/images/provice_educational.png
  AssetGenImage get proviceEducational =>
      const AssetGenImage('assets/images/images/provice_educational.png');

  /// File path: assets/images/images/provide_community.png
  AssetGenImage get provideCommunity =>
      const AssetGenImage('assets/images/images/provide_community.png');

  /// File path: assets/images/images/provide_tracking.png
  AssetGenImage get provideTracking =>
      const AssetGenImage('assets/images/images/provide_tracking.png');

  /// File path: assets/images/images/schedule_manager.png
  AssetGenImage get scheduleManager =>
      const AssetGenImage('assets/images/images/schedule_manager.png');

  /// File path: assets/images/images/welcome_safebump.png
  AssetGenImage get welcomeSafebump =>
      const AssetGenImage('assets/images/images/welcome_safebump.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        appleLogo,
        ggLogo,
        icCorrect,
        icWrong,
        logo,
        medicine,
        proviceEducational,
        provideCommunity,
        provideTracking,
        scheduleManager,
        welcomeSafebump
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonsGen jsons = $AssetsJsonsGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
