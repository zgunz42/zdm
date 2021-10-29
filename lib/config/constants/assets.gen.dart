/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesAppImagesGen get appImages => const $AssetsImagesAppImagesGen();
  $AssetsImagesEmptyStateGen get emptyState =>
      const $AssetsImagesEmptyStateGen();
  $AssetsImagesIconsGen get icons => const $AssetsImagesIconsGen();
}

class $AssetsImagesAppImagesGen {
  const $AssetsImagesAppImagesGen();

  AssetGenImage get launcherIcon =>
      const AssetGenImage('assets/images/app_images/launcher_icon.png');
  AssetGenImage get splashLogo =>
      const AssetGenImage('assets/images/app_images/splash_logo.png');
}

class $AssetsImagesEmptyStateGen {
  const $AssetsImagesEmptyStateGen();

  AssetGenImage get file =>
      const AssetGenImage('assets/images/empty_state/file.png');
}

class $AssetsImagesIconsGen {
  const $AssetsImagesIconsGen();

  SvgGenImage get ai => const SvgGenImage('assets/images/icons/ai.svg');
  SvgGenImage get android =>
      const SvgGenImage('assets/images/icons/android.svg');
  SvgGenImage get apk => const SvgGenImage('assets/images/icons/apk.svg');
  SvgGenImage get css => const SvgGenImage('assets/images/icons/css.svg');
  SvgGenImage get disc => const SvgGenImage('assets/images/icons/disc.svg');
  SvgGenImage get doc => const SvgGenImage('assets/images/icons/doc.svg');
  SvgGenImage get excel => const SvgGenImage('assets/images/icons/excel.svg');
  SvgGenImage get font => const SvgGenImage('assets/images/icons/font.svg');
  SvgGenImage get iso => const SvgGenImage('assets/images/icons/iso.svg');
  SvgGenImage get javascript =>
      const SvgGenImage('assets/images/icons/javascript.svg');
  SvgGenImage get jpg => const SvgGenImage('assets/images/icons/jpg.svg');
  SvgGenImage get js => const SvgGenImage('assets/images/icons/js.svg');
  SvgGenImage get mail => const SvgGenImage('assets/images/icons/mail.svg');
  SvgGenImage get mp3 => const SvgGenImage('assets/images/icons/mp3.svg');
  SvgGenImage get mp4 => const SvgGenImage('assets/images/icons/mp4.svg');
  SvgGenImage get music => const SvgGenImage('assets/images/icons/music.svg');
  SvgGenImage get pdf => const SvgGenImage('assets/images/icons/pdf.svg');
  SvgGenImage get php => const SvgGenImage('assets/images/icons/php.svg');
  SvgGenImage get play => const SvgGenImage('assets/images/icons/play.svg');
  SvgGenImage get powerpoint =>
      const SvgGenImage('assets/images/icons/powerpoint.svg');
  SvgGenImage get ppt => const SvgGenImage('assets/images/icons/ppt.svg');
  SvgGenImage get psd => const SvgGenImage('assets/images/icons/psd.svg');
  SvgGenImage get record => const SvgGenImage('assets/images/icons/record.svg');
  SvgGenImage get sql => const SvgGenImage('assets/images/icons/sql.svg');
  SvgGenImage get svg => const SvgGenImage('assets/images/icons/svg.svg');
  SvgGenImage get text => const SvgGenImage('assets/images/icons/text.svg');
  SvgGenImage get ttf => const SvgGenImage('assets/images/icons/ttf.svg');
  SvgGenImage get txt => const SvgGenImage('assets/images/icons/txt.svg');
  SvgGenImage get vcf => const SvgGenImage('assets/images/icons/vcf.svg');
  SvgGenImage get vector => const SvgGenImage('assets/images/icons/vector.svg');
  SvgGenImage get video => const SvgGenImage('assets/images/icons/video.svg');
  SvgGenImage get word => const SvgGenImage('assets/images/icons/word.svg');
  SvgGenImage get xls => const SvgGenImage('assets/images/icons/xls.svg');
  SvgGenImage get zip => const SvgGenImage('assets/images/icons/zip.svg');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
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
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
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
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  String get path => _assetName;
}
