import 'package:flutter/widgets.dart';
import 'painter.dart';

/// A widget that draws a checkmark on a [CustomPaint].
///
/// The [RawCheckmark] widget provides a customizable checkmark that can be used
/// within any layout. It leverages a [CustomPainter] to render the checkmark.
class RawCheckmark extends CustomPaint {
  /// Creates a [RawCheckmark] widget.
  ///
  /// The [progress], [color], [weight], [rounded], and [size] parameters
  /// allow customization of the checkmark's appearance.
  RawCheckmark({
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
