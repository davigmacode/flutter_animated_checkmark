![Pub Version](https://img.shields.io/pub/v/animated_checkmark) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_animated_checkmark)

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width="195" height="55"></a>

Easy way to displaying, animating, and styling checkmark icon.

## Preview

[![Preview](https://github.com/davigmacode/flutter_animated_checkmark/raw/master/media/preview.gif)](https://davigmacode.github.io/flutter_animated_checkmark)

[Demo](https://davigmacode.github.io/flutter_animated_checkmark)

## Features

* Animated show/hide by active flag or progress value.
* Animated color, weight, and size.
* Sharp or round style.

## Usage

For a complete usage, please see the [example](https://pub.dev/packages/animated_checkmark#-example-tab-).

To read more about classes and other references used by `animated_checkmark`, see the [API Reference](https://pub.dev/documentation/animated_checkmark/latest/).

```dart
// animate by active flag
AnimatedCheckmark(
  active: true,
  weight: 2,
  size: const Size.square(12),
  color: Colors.blue,
  style: CheckmarkStyle.round,
);

// animate by progress value [0.0-1.0]
Checkmark(
  progress: 0.5,
  weight: 2,
  size: const Size.square(12),
  color: Colors.blue,
  style: CheckmarkStyle.round,
);
```