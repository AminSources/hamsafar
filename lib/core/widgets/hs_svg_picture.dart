import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';

class HsSvgPicture extends StatefulWidget {
  final String assetPath;
  final Color targetColor;
  final String? originalColorHex;
  final double? width;
  final double? height;

  const HsSvgPicture({
    super.key,
    required this.assetPath,
    required this.targetColor,
    this.originalColorHex,
    this.width,
    this.height,
  });

  @override
  State<HsSvgPicture> createState() => _HsSvgPictureState();
}

class _HsSvgPictureState extends State<HsSvgPicture> {
  String? _svgString;

  @override
  void initState() {
    super.initState();
    _loadAndModifySvg();
  }

  Future<void> _loadAndModifySvg() async {
    String rawSvg = await rootBundle.loadString(widget.assetPath);

    final String newColorHex =
        '#${widget.targetColor.toARGB32().toRadixString(16).substring(2).toUpperCase()}';

    final modifiedSvg = rawSvg
        .replaceAll(
          widget.originalColorHex ?? "#6c63ff".toLowerCase(),
          newColorHex,
        )
        .replaceAll(
          widget.originalColorHex ?? "#6c63ff".toUpperCase(),
          newColorHex,
        );

    if (mounted) {
      setState(() {
        _svgString = modifiedSvg;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_svgString == null) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return SvgPicture.string(
      _svgString!,
      width: widget.width,
      height: widget.height,
      fit: BoxFit.contain,
    );
  }
}
