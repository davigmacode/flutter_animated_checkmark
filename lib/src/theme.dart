import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'theme_data.dart';

/// A Widget that controls how descendant [Checkmark]s should look like.
class CheckmarkTheme extends InheritedTheme {
  /// The properties for descendant [Checkmark]s
  final CheckmarkThemeData data;

  /// Creates a theme that controls
  /// how descendant [Checkmark]s should look like.
  const CheckmarkTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Creates an [CheckmarkTheme] that controls the style of
  /// descendant widgets, and merges in the current [CheckmarkTheme], if any.
  ///
  /// The [style] and [child] arguments must not be null.
  static Widget merge({
    Key? key,
    Curve? curve,
    Duration? duration,
    Color? color,
    double? weight,
    double? size,
    bool? autoSize,
    bool? rounded,
    bool? drawCross,
    bool? drawDash,
    CheckmarkThemeData? data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        final parent = CheckmarkTheme.of(context);
        return CheckmarkTheme(
          key: key,
          data: parent.merge(data).copyWith(
                curve: curve,
                duration: duration,
                color: color,
                weight: weight,
                size: size,
                autoSize: autoSize,
                rounded: rounded,
                drawCross: drawCross,
                drawDash: drawDash,
              ),
          child: child,
        );
      },
    );
  }

  /// The [data] from the closest instance of
  /// this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// CheckmarkThemeData theme = CheckmarkTheme.of(context);
  /// ```
  static CheckmarkThemeData? maybeOf(BuildContext context) {
    final parentTheme =
        context.dependOnInheritedWidgetOfExactType<CheckmarkTheme>();
    if (parentTheme != null) return parentTheme.data;

    final globalTheme = Theme.of(context).extension<CheckmarkThemeData>();
    return globalTheme;
  }

  /// The [data] from the closest instance of
  /// this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// CheckmarkThemeData theme = CheckmarkTheme.of(context);
  /// ```
  static CheckmarkThemeData of(BuildContext context) {
    final parentTheme = CheckmarkTheme.maybeOf(context);
    if (parentTheme != null) return parentTheme;

    return const CheckmarkThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return CheckmarkTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(CheckmarkTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('data', data));
  }
}
