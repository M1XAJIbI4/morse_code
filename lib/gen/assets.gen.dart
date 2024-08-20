/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

// Flutter imports:
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/close_icon.svg
  SvgGenImage get closeIcon =>
      const SvgGenImage('assets/images/close_icon.svg');

  /// File path: assets/images/copy_icon.svg
  SvgGenImage get copyIcon => const SvgGenImage('assets/images/copy_icon.svg');

  /// File path: assets/images/en_flag_icon.svg
  SvgGenImage get enFlagIcon =>
      const SvgGenImage('assets/images/en_flag_icon.svg');

  /// File path: assets/images/favorites_tab.svg
  SvgGenImage get favoritesTab =>
      const SvgGenImage('assets/images/favorites_tab.svg');

  /// File path: assets/images/logo.png
  AssetGenImage get logoPng => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/logo.svg
  SvgGenImage get logoSvg => const SvgGenImage('assets/images/logo.svg');

  /// File path: assets/images/morse_icon.svg
  SvgGenImage get morseIcon =>
      const SvgGenImage('assets/images/morse_icon.svg');

  /// File path: assets/images/speak_icon.svg
  SvgGenImage get speakIcon =>
      const SvgGenImage('assets/images/speak_icon.svg');

  /// File path: assets/images/star_active_icon.svg
  SvgGenImage get starActiveIcon =>
      const SvgGenImage('assets/images/star_active_icon.svg');

  /// File path: assets/images/star_icon.svg
  SvgGenImage get starIcon => const SvgGenImage('assets/images/star_icon.svg');

  /// File path: assets/images/swap_icon.svg
  SvgGenImage get swapIcon => const SvgGenImage('assets/images/swap_icon.svg');

  /// File path: assets/images/translate_tab.svg
  SvgGenImage get translateTab =>
      const SvgGenImage('assets/images/translate_tab.svg');

  /// List of all assets
  List<dynamic> get values => [
        closeIcon,
        copyIcon,
        enFlagIcon,
        favoritesTab,
        logoPng,
        logoSvg,
        morseIcon,
        speakIcon,
        starActiveIcon,
        starIcon,
        swapIcon,
        translateTab
      ];
}

class $AssetsSoundsGen {
  const $AssetsSoundsGen();

  /// File path: assets/sounds/dash.mp3
  String get dash => 'assets/sounds/dash.mp3';

  /// File path: assets/sounds/dot.mp3
  String get dot => 'assets/sounds/dot.mp3';

  /// File path: assets/sounds/void_long.mp3
  String get voidLong => 'assets/sounds/void_long.mp3';

  /// File path: assets/sounds/void_short.mp3
  String get voidShort => 'assets/sounds/void_short.mp3';

  /// List of all assets
  List<String> get values => [dash, dot, voidLong, voidShort];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSoundsGen sounds = $AssetsSoundsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

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
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final BytesLoader loader;
    if (_isVecFormat) {
      loader = AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
