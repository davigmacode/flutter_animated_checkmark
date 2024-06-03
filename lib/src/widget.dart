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
    Key? key,
    this.color,
    this.weight,
    this.size,
    this.rounded = false,
    this.value = true,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.linear,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
        );

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

  /// Whether to show the checkmark.
  ///
  /// Defaults to `true`.
  final bool? value;

  @override
  AnimatedCheckmarkState createState() => AnimatedCheckmarkState();
}

class AnimatedCheckmarkState
    extends AnimatedWidgetBaseState<AnimatedCheckmark> {
  Tween<double>? progress;
  Tween<double>? weight;
  Tween<double?>? size;
  ColorTween? color;

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
      widget.weight,
      (dynamic value) => Tween<double>(begin: value),
    ) as Tween<double>?;

    size = visitor(
      size,
      widget.size,
      (dynamic value) => Tween<double?>(begin: value),
    ) as Tween<double?>?;

    color = visitor(
      color,
      widget.color,
      (dynamic value) => ColorTween(begin: value),
    ) as ColorTween?;
  }

  @override
  Widget build(BuildContext context) {
    return Checkmark(
      progress: progress?.evaluate(animation),
      color: color?.evaluate(animation),
      weight: weight?.evaluate(animation),
      size: size?.evaluate(animation),
      rounded: widget.rounded,
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
    double? size,
  }) : super(
          key: key,
          size: size != null ? Size.square(size) : Size.zero,
          painter: CheckmarkPainter(
            progress: progress,
            color: color,
            weight: weight ?? (size != null ? size / 5 : 0),
            rounded: rounded,
          ),
        );
}
