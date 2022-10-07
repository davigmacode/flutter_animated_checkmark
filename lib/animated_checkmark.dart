library animated_checkmark;

import 'package:flutter/widgets.dart';

enum CheckmarkStyle {
  round,
  sharp,
}

class AnimatedCheckmark extends ImplicitlyAnimatedWidget {
  const AnimatedCheckmark({
    Key? key,
    this.color,
    this.weight,
    this.style,
    this.size = Size.zero,
    this.active = false,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.linear,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
        );

  final Color? color;
  final double? weight;
  final CheckmarkStyle? style;
  final Size size;
  final bool active;

  @override
  AnimatedCheckmarkState createState() => AnimatedCheckmarkState();
}

class AnimatedCheckmarkState
    extends AnimatedWidgetBaseState<AnimatedCheckmark> {
  Tween<double>? progress;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    progress = visitor(
      progress,
      widget.active ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>;
  }

  @override
  Widget build(BuildContext context) {
    return Checkmark(
      progress: progress?.evaluate(animation),
      color: widget.color,
      weight: widget.weight,
      style: widget.style,
      size: widget.size,
    );
  }
}

class Checkmark extends CustomPaint {
  Checkmark({
    Key? key,
    double? progress,
    Color? color,
    double? weight,
    CheckmarkStyle? style,
    Size size = Size.zero,
  }) : super(
          key: key,
          size: size,
          painter: CheckmarkPainter(
            progress: progress,
            color: color,
            weight: weight,
            style: style,
          ),
        );
}

class CheckmarkPainter extends CustomPainter {
  CheckmarkPainter({
    double? progress,
    Color? color,
    double? weight,
    CheckmarkStyle? style,
  })  : progress = progress ?? 1.0,
        color = color ?? const Color(0xDD000000),
        weight = weight ?? 1.0,
        style = style ?? CheckmarkStyle.sharp;

  final double progress;
  final Color color;
  final double weight;
  final CheckmarkStyle style;

  @override
  bool shouldRepaint(CheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.weight != weight;
  }

  @override
  void paint(Canvas canvas, Size size) {
    assert(progress >= 0.0 && progress <= 1.0);
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
    final bool isSharped = style == CheckmarkStyle.sharp;
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeJoin = isSharped ? StrokeJoin.miter : StrokeJoin.round
      ..strokeCap =
          isSharped || progress == 0 ? StrokeCap.butt : StrokeCap.round
      ..strokeWidth = weight;
    canvas.drawPath(path, paint);
  }
}
