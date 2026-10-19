import 'package:flutter/material.dart';

import '../../core/constants/niva_colors.dart';
import '../../core/theme/niva_typography.dart';

/// Renders the official NIVA geometric N brand symbol.
///
/// Supports either the transparent PNG asset or the vector interpretation.
class NivaSymbol extends StatelessWidget {
  const NivaSymbol({super.key, this.size = 48.0, this.useRasterAsset = false});

  final double size;
  final bool useRasterAsset;

  @override
  Widget build(BuildContext context) {
    if (useRasterAsset) {
      return Image.asset(
        'assets/branding/NIVA_N_Color_Transparent.png',
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) => _buildVectorSymbol(),
      );
    }
    return _buildVectorSymbol();
  }

  Widget _buildVectorSymbol() {
    return Semantics(
      label: 'NIVA brand symbol',
      child: CustomPaint(
        size: Size(size, size),
        painter: const _NivaSymbolPainter(),
      ),
    );
  }
}

/// Official NIVA Brand Logo widget using the transparent brand assets.
class NivaBrandLogo extends StatelessWidget {
  const NivaBrandLogo({super.key, this.width = 180.0, this.showTagline = true});

  final double width;
  final bool showTagline;

  @override
  Widget build(BuildContext context) {
    final assetPath = showTagline
        ? 'assets/branding/NIVA_Logo_With_Tagline.png'
        : 'assets/branding/NIVA_Logo_Without_Tagline.png';

    return Image.asset(
      assetPath,
      width: width,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const NivaSymbol(size: 64);
      },
    );
  }
}

class _NivaSymbolPainter extends CustomPainter {
  const _NivaSymbolPainter();

  // SVG viewBox is 512x512
  static const double _viewBoxSize = 512.0;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / _viewBoxSize;
    canvas.save();
    canvas.scale(scale, scale);

    // 1. Blue gradient on the primary 'N' path
    final gradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [NivaColors.deepNavy, NivaColors.electricCyan],
    ).createShader(const Rect.fromLTWH(0, 0, _viewBoxSize, _viewBoxSize));

    final bluePaint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.fill;

    // SVG path 1: M92 420V112c0-28 37-40 55-18l216 250V92h58v308c0 29-38 40-57 18L150 166v254z
    final basePath = Path()
      ..moveTo(92, 420)
      ..lineTo(92, 112)
      ..cubicTo(92, 84, 129, 72, 147, 94)
      ..lineTo(363, 344)
      ..lineTo(363, 92)
      ..lineTo(421, 92)
      ..lineTo(421, 400)
      ..cubicTo(421, 429, 383, 440, 364, 418)
      ..lineTo(150, 166)
      ..lineTo(150, 420)
      ..close();

    canvas.drawPath(basePath, bluePaint);

    // 2. Teal accent triangle/wedge
    // SVG path 2: M175 294l67 78v57h-67z
    final tealPaint = Paint()
      ..color = NivaColors.teal
      ..style = PaintingStyle.fill;

    final accentPath = Path()
      ..moveTo(175, 294)
      ..lineTo(242, 372)
      ..lineTo(242, 429)
      ..lineTo(175, 429)
      ..close();

    canvas.drawPath(accentPath, tealPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
