import 'package:flutter/widgets.dart';
import 'painter.dart';

/// A widget that animates a checkmark.
///
/// The checkmark's properties, such as color, weight, size, and roundness,
/// can be animated over a given duration and curve.
class AnimatedCheckmark extends ImplicitlyAnimatedWidget {
  /// Creates an [AnimatedCheckmark] widget.
  ///
  /// The [duration] and [curve] parameters control the animation of the checkmark's properties.
  /// The [color], [weight], [size], [rounded], and [value] parameters allow customization of
  /// the checkmark's appearance.
  ///
  /// The [duration] defaults to 200 milliseconds, [curve] defaults to [Curves.linear],
  /// [rounded] defaults to `false`, and [value] defaults to `true`.
  const AnimatedCheckmark({
    super.key,
    super.duration = const Duration(milliseconds: 200),
    super.curve = Curves.linear,
    this.color,
    this.weight,
    this.size,
    this.rounded = false,
    this.drawCross = false,
    this.drawDash = true,
    this.value = true,
  });

  /// The color of the checkmark.
  ///
  /// Defaults to [Colors.black87].
  final Color? color;

  /// The stroke width of the checkmark.
  ///
  /// Defaults to [size] divided by 5.
  final double? weight;

  /// The size of the checkmark. If null, the checkmark expands to fit its parent.
  ///
  /// Defaults to parent size.
  final double? size;

  /// Whether the checkmark has rounded edges.
  ///
  /// Defaults to `false`.
  final bool rounded;

  /// Whether to draw a cross when [value] is `false`.
  ///
  /// Defaults to `false`.
  final bool drawCross;

  /// Whether to draw a dash when [value] is `null`.
  ///
  /// Defaults to `true`.
  final bool drawDash;

  /// Whether to show the checkmark.
  ///
  /// Defaults to `true`.
  final bool? value;

  /// The effective color of the checkmark.
  ///
  /// This is either the value of [color] or [Colors.black87] if [color] is null.
  Color get effectiveColor => color ?? const Color(0xDD000000);

  /// The effective stroke width of the checkmark.
  ///
  /// This is either the value of [weight] or [size] divided by 5 if [weight] is null.
  double get effectiveWeight => weight ?? (size != null ? size! / 5 : 0);

  @override
  AnimatedCheckmarkState createState() => AnimatedCheckmarkState();
}

class AnimatedCheckmarkState
    extends AnimatedWidgetBaseState<AnimatedCheckmark> {
  Tween<double>? progress;
  Tween<double>? weight;
  Tween<double?>? size;
  ColorTween? color;

  bool? oldValue = true;

  bool get edgeToEdge =>
      (widget.value == true && oldValue == null) ||
      (widget.value == null && oldValue == true);

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    progress = visitor(
      progress,
      widget.value == null
          ? -1.0
          : widget.value == true
              ? 1.0
              : 0.0,
      (dynamic value) => Tween<double>(begin: value),
    ) as Tween<double>?;

    weight = visitor(
      weight,
      widget.effectiveWeight,
      (dynamic value) => Tween<double>(begin: value),
    ) as Tween<double>?;

    size = visitor(
      size,
      widget.size,
      (dynamic value) => Tween<double?>(begin: value),
    ) as Tween<double?>?;

    color = visitor(
      color,
      widget.effectiveColor,
      (dynamic value) => ColorTween(begin: value),
    ) as ColorTween?;
  }

  @override
  void didUpdateWidget(covariant AnimatedCheckmark oldWidget) {
    oldValue = oldWidget.value;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Checkmark(
      progress: progress?.evaluate(animation),
      color: color?.evaluate(animation),
      weight: weight?.evaluate(animation),
      size: size?.evaluate(animation),
      rounded: widget.rounded,
      drawCross: widget.drawCross && !edgeToEdge,
      drawDash: widget.drawDash,
    );
  }
}

/// A widget that draws a checkmark on a [CustomPaint].
///
/// The [Checkmark] widget provides a customizable checkmark that can be used
/// within any layout. It leverages a [CustomPainter] to render the checkmark.
class Checkmark extends CustomPaint {
  /// Creates a [Checkmark] widget.
  ///
  /// The [progress], [color], [weight], [rounded], and [size] parameters
  /// allow customization of the checkmark's appearance.
  Checkmark({
    Key? key,
    double? progress,
    Color? color,
    double? weight,
    bool? rounded,
    bool? drawCross,
    bool? drawDash,
    double? size,
  }) : super(
          key: key,
          size: size != null ? Size.square(size) : Size.zero,
          painter: CheckmarkPainter(
            progress: progress,
            color: color,
            weight: weight ?? (size != null ? size / 5 : 0),
            rounded: rounded,
            drawCross: drawCross,
            drawDash: drawDash,
          ),
        );
}
