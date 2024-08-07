import 'package:flutter/widgets.dart';
import 'raw.dart';

/// A widget that animates a checkmark.
///
/// The checkmark's properties, such as color, weight, size, and roundness,
/// can be animated over a given duration and curve.
class CheckmarkRender extends ImplicitlyAnimatedWidget {
  /// Creates an [CheckmarkRender] widget.
  ///
  /// The [duration] and [curve] parameters control the animation of the checkmark's properties.
  /// The [color], [weight], [size], [rounded], and [value] parameters allow customization of
  /// the checkmark's appearance.
  ///
  /// The [duration] defaults to 200 milliseconds, [curve] defaults to [Curves.linear],
  /// [rounded] defaults to `false`, and [value] defaults to `true`.
  const CheckmarkRender({
    super.key,
    required super.curve,
    required super.duration,
    required this.color,
    required this.weight,
    required this.size,
    required this.rounded,
    required this.drawCross,
    required this.drawDash,
    required this.checked,
    required this.indeterminate,
  });

  final Color color;
  final double? weight;
  final double? size;
  final bool rounded;
  final bool drawCross;
  final bool drawDash;
  final bool checked;
  final bool indeterminate;

  /// The effective stroke width of the checkmark.
  ///
  /// This is either the value of [weight] or [size] divided by 5 if [weight] is null.
  double get effectiveWeight => weight ?? (size != null ? size! / 5 : 0);

  @override
  CheckmarkRenderState createState() => CheckmarkRenderState();
}

class CheckmarkRenderState extends AnimatedWidgetBaseState<CheckmarkRender> {
  Tween<double>? progress;
  Tween<double>? weight;
  Tween<double?>? size;
  ColorTween? color;

  bool edgeToEdge = true;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    progress = visitor(
      progress,
      widget.indeterminate
          ? -1.0
          : widget.checked
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
      widget.color,
      (dynamic value) => ColorTween(begin: value),
    ) as ColorTween?;
  }

  @override
  void didUpdateWidget(covariant CheckmarkRender oldWidget) {
    edgeToEdge = (widget.checked && oldWidget.indeterminate) ||
        (widget.indeterminate && oldWidget.checked);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RawCheckmark(
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
