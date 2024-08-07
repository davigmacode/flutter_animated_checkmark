import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Defines the visual properties of [Checkmark].
///
/// Descendant widgets obtain the current [CheckmarkThemeData] object using
/// `DrivenSpinnerTheme.of(context)`. Instances of [CheckmarkThemeData]
/// can be customized with [CheckmarkThemeData.copyWith] or [CheckmarkThemeData.merge].
class CheckmarkThemeData extends ThemeExtension<CheckmarkThemeData>
    with Diagnosticable {
  /// The curve to apply when animating the parameters of sheet widget.
  final Curve curve;

  /// The duration over which to animate the parameters of sheet widget.
  final Duration duration;

  /// The color of the checkmark.
  final Color color;

  /// The stroke width of the checkmark.
  final double? weight;

  /// The size of the checkmark. If null, the checkmark expands to fit its parent.
  final double? size;

  /// Whether the spinner's stroke is rounded.
  final bool rounded;

  /// Whether to draw a cross when [value] is `false`.
  final bool drawCross;

  /// Whether to draw a dash when [value] is `null`.
  final bool drawDash;

  /// Creates a theme data that can be used for [CheckmarkThemeData].
  const CheckmarkThemeData({
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 200),
    this.color = Colors.black,
    this.weight,
    this.size,
    this.rounded = false,
    this.drawCross = false,
    this.drawDash = true,
  });

  /// Creates a [CheckmarkThemeData] from another one that probably null.
  CheckmarkThemeData.from([
    CheckmarkThemeData? other,
    CheckmarkThemeData fallback = const CheckmarkThemeData(),
  ])  : curve = other?.curve ?? fallback.curve,
        duration = other?.duration ?? fallback.duration,
        color = other?.color ?? fallback.color,
        weight = other?.weight ?? fallback.weight,
        size = other?.size ?? fallback.size,
        rounded = other?.rounded ?? fallback.rounded,
        drawCross = other?.drawCross ?? fallback.drawCross,
        drawDash = other?.drawDash ?? fallback.drawDash;

  /// Creates a copy of this [CheckmarkThemeData] but with
  /// the given fields replaced with the new values.
  @override
  CheckmarkThemeData copyWith({
    Curve? curve,
    Duration? duration,
    Color? color,
    double? weight,
    double? size,
    bool? rounded,
    bool? drawCross,
    bool? drawDash,
  }) {
    return CheckmarkThemeData(
      curve: curve ?? this.curve,
      duration: duration ?? this.duration,
      color: color ?? this.color,
      weight: weight ?? this.weight,
      size: size ?? this.size,
      rounded: rounded ?? this.rounded,
      drawCross: drawCross ?? this.drawCross,
      drawDash: drawDash ?? this.drawDash,
    );
  }

  /// Creates a copy of this [CheckmarkThemeData] but with
  /// the given fields replaced with the new values.
  CheckmarkThemeData merge(CheckmarkThemeData? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      curve: other.curve,
      duration: other.duration,
      color: other.color,
      weight: other.weight,
      size: other.size,
      rounded: other.rounded,
      drawCross: other.drawCross,
      drawDash: other.drawDash,
    );
  }

  @override
  CheckmarkThemeData lerp(CheckmarkThemeData? other, double t) {
    if (other is! CheckmarkThemeData) return this;
    return CheckmarkThemeData(
      curve: t < 0.5 ? curve : other.curve,
      duration: t < 0.5 ? duration : other.duration,
      color: Color.lerp(color, other.color, t) ?? color,
      weight: lerpDouble(weight, other.weight, t) ?? weight,
      size: lerpDouble(size, other.size, t),
      rounded: t < 0.5 ? rounded : other.rounded,
      drawCross: t < 0.5 ? drawCross : other.drawCross,
      drawDash: t < 0.5 ? drawDash : other.drawDash,
    );
  }

  Map<String, dynamic> toMap() => {
        'curve': curve,
        'duration': duration,
        'color': color,
        'width': weight,
        'size': size,
        'rounded': rounded,
        'drawCross': drawCross,
        'drawDash': drawDash,
      };

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is CheckmarkThemeData && mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => Object.hashAll(toMap().values);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    toMap().entries.forEach((el) {
      properties.add(DiagnosticsProperty(el.key, el.value, defaultValue: null));
    });
  }
}
