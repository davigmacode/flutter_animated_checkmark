import 'package:flutter/widgets.dart';
import 'render.dart';
import 'theme.dart';

/// A widget that animates a checkmark.
///
/// The checkmark's properties, such as color, weight, size, and roundness,
/// can be animated over a given duration and curve.
class Checkmark extends StatelessWidget {
  /// Creates an [CheckmarkRender] widget.
  ///
  /// The [duration] and [curve] parameters control the animation of the checkmark's properties.
  /// The [color], [weight], [size], [rounded], [checked] and [indeterminate] parameters
  /// allow customization of the checkmark's appearance.
  ///
  /// The [duration] defaults to 200 milliseconds, [curve] defaults to [Curves.linear],
  /// [rounded] defaults to `false`, [checked] defaults to `true`,
  /// and [indeterminate] defaults to `false`.
  const Checkmark({
    super.key,
    this.curve,
    this.duration,
    this.color,
    this.weight,
    this.size,
    this.autoSize,
    this.rounded,
    this.drawCross,
    this.drawDash,
    this.checked = true,
    this.indeterminate = false,
  });

  /// The curve to apply when animating the parameters of sheet widget.
  final Curve? curve;

  /// The duration over which to animate the parameters of sheet widget.
  final Duration? duration;

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

  /// Whether to automatically size the checkmark to fit its content.
  ///
  /// If `true`, the checkmark will be sized to fit its content (checked, cross, dash, or space).
  /// Otherwise, the `size` property will be used.
  ///
  /// Defaults to `true`.
  final bool? autoSize;

  /// Whether the checkmark has rounded edges.
  ///
  /// Defaults to `false`.
  final bool? rounded;

  /// Whether to draw a cross when the checkmark is unchecked.
  ///
  /// Defaults to `false`.
  final bool? drawCross;

  /// Whether to draw a dash when the checkmark is indeterminate.
  ///
  /// Defaults to `true`.
  final bool? drawDash;

  /// Whether to show the checkmark.
  ///
  /// Defaults to `true`.
  final bool checked;

  /// Whether the checkmark is in an indeterminate state.
  ///
  /// Defaults to `false`.
  final bool indeterminate;

  @override
  Widget build(BuildContext context) {
    final theme = CheckmarkTheme.of(context);
    return CheckmarkRender(
      curve: curve ?? theme.curve,
      duration: duration ?? theme.duration,
      color: color ?? theme.color,
      weight: weight ?? theme.weight,
      size: size ?? theme.size,
      autoSize: autoSize ?? theme.autoSize,
      rounded: rounded ?? theme.rounded,
      drawCross: drawCross ?? theme.drawCross,
      drawDash: drawDash ?? theme.drawDash,
      checked: checked,
      indeterminate: indeterminate,
    );
  }
}
