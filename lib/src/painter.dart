import 'package:flutter/widgets.dart';

class CheckmarkPainter extends CustomPainter {
  CheckmarkPainter({
    double? progress,
    Color? color,
    double? weight,
    bool? rounded,
  })  : progress = progress ?? 1.0,
        color = color ?? const Color(0xDD000000),
        weight = weight ?? 1.0,
        rounded = rounded ?? false;

  /// Defaults to 1.0
  final double progress;

  /// Defaults to [Colors.black87]
  final Color color;

  /// Defaults to 1.0
  final double weight;

  /// Defaults to false
  final bool rounded;

  @override
  bool shouldRepaint(CheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.weight != weight ||
        oldDelegate.rounded != rounded;
  }

  @override
  void paint(Canvas canvas, Size size) {
    assert(progress >= -1.0 && progress <= 1.0);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeJoin = rounded ? StrokeJoin.round : StrokeJoin.miter
      ..strokeCap = !rounded || progress == 0 ? StrokeCap.butt : StrokeCap.round
      ..strokeWidth = weight;

    if (progress > 0) {
      _drawCheck(canvas, size, paint);
    } else {
      _drawDash(canvas, size, paint);
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
    final drawStart = Offset.lerp(start, mid, 1.0 - (-progress))!;
    final drawEnd = Offset.lerp(mid, end, -progress)!;
    canvas.drawLine(drawStart, drawEnd, paint);
  }
}
