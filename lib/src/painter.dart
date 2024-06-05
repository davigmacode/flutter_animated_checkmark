import 'package:flutter/widgets.dart';

/// A [CustomPainter] that paints a checkmark on a canvas.
///
/// The [CheckmarkPainter] class is responsible for drawing the checkmark
/// with the given properties, such as progress, color, weight, and roundness.
class CheckmarkPainter extends CustomPainter {
  /// Creates a [CheckmarkPainter] for painting a checkmark on a canvas.
  ///
  /// The [progress], [color], [weight], and [rounded] parameters
  /// allow customization of the checkmark's appearance.
  CheckmarkPainter({
    double? progress,
    Color? color,
    double? weight,
    bool? rounded,
    bool? drawCross,
    bool? drawDash,
  })  : progress = progress ?? 1.0,
        color = color ?? const Color(0xDD000000),
        weight = weight ?? 1.0,
        drawCross = drawCross ?? false,
        drawDash = drawDash ?? true,
        rounded = rounded ?? false;

  /// The progress of the checkmark animation.
  ///
  /// Defaults to `1.0`.
  final double progress;

  /// The color of the checkmark.
  ///
  /// Defaults to [Colors.black87].
  final Color color;

  /// The stroke width of the checkmark.
  ///
  /// Defaults to `1.0`.
  final double weight;

  /// Whether the checkmark has rounded edges.
  ///
  /// Defaults to `false`.
  final bool rounded;

  /// Whether to draw a cross when progress reach `0`.
  ///
  /// Defaults to `false`.
  final bool drawCross;

  /// Whether to draw a dash when progress reach `-1`.
  ///
  /// Defaults to `true`.
  final bool drawDash;

  @override
  bool shouldRepaint(CheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.weight != weight ||
        oldDelegate.rounded != rounded ||
        oldDelegate.drawCross != drawCross ||
        oldDelegate.drawDash != drawDash;
  }

  @override
  void paint(Canvas canvas, Size size) {
    assert(progress >= -1.0 && progress <= 1.0);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeJoin = rounded ? StrokeJoin.round : StrokeJoin.miter
      ..strokeCap = !rounded ? StrokeCap.butt : StrokeCap.round
      ..strokeWidth = weight;

    if (progress > 0) {
      _drawCheck(canvas, size, paint);
    } else if (progress < 0) {
      if (drawDash) _drawDash(canvas, size, paint);
    }

    if (drawCross && progress > -1 && progress < 1) {
      _drawCross(canvas, size, paint);
    }
  }

  void _drawCheck(Canvas canvas, Size size, Paint paint) {
    // As t goes from 0.0 to 1.0, animate the two check mark strokes from the
    // short side to the long side.
    const origin = Offset(0, 0);
    final Path path = Path();
    final Offset start = Offset(size.width * 0.15, size.height * 0.45);
    final Offset mid = Offset(size.width * 0.4, size.height * 0.7);
    final Offset end = Offset(size.width * 0.85, size.height * 0.25);
    if (progress < 0.5) {
      final double strokeT = progress * 2.0;
      final Offset drawMid = Offset.lerp(start, mid, strokeT)!;
      path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
      path.lineTo(origin.dx + drawMid.dx, origin.dy + drawMid.dy);
    } else {
      final double strokeT = (progress - 0.5) * 2.0;
      final Offset drawEnd = Offset.lerp(mid, end, strokeT)!;
      path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
      path.lineTo(origin.dx + mid.dx, origin.dy + mid.dy);
      path.lineTo(origin.dx + drawEnd.dx, origin.dy + drawEnd.dy);
    }
    canvas.drawPath(path, paint);
  }

  void _drawDash(Canvas canvas, Size size, Paint paint) {
    // As t goes from 0.0 to -1.0,
    // animate the horizontal line
    // from the mid point outwards.
    final center = size.center(Offset.zero);
    final width = size.width;
    final start = Offset(width * 0.15, center.dy);
    final mid = Offset(width * 0.5, center.dy);
    final end = Offset(width * 0.85, center.dy);
    final drawStart = Offset.lerp(start, mid, 1.0 + progress)!;
    final drawEnd = Offset.lerp(mid, end, -progress)!;
    canvas.drawLine(drawStart, drawEnd, paint);
  }

  void _drawCross(Canvas canvas, Size size, Paint paint) {
    // Calculate inset based on size and ratio
    final inset = (size.width / 2) * .4;
    final t = 1 - progress.abs();

    // Draw the \ line
    final startPointTop = Offset(size.width - inset, size.height - inset);
    final endPointBottom = Offset(inset, inset);
    final drawEndPointBottom = Offset.lerp(startPointTop, endPointBottom, t)!;
    canvas.drawLine(startPointTop, drawEndPointBottom, paint);

    if (t > .5) {
      // Draw the / line
      final startPointBottom = Offset(size.width - inset, inset);
      final endPointTop = Offset(inset, size.height - inset);
      final drawEndPointTop = Offset.lerp(startPointBottom, endPointTop, t)!;
      canvas.drawLine(startPointBottom, drawEndPointTop, paint);
    }
  }
}
