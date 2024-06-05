[![Pub Version](https://img.shields.io/pub/v/animated_checkmark)](https://pub.dev/packages/animated_checkmark) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_animated_checkmark) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

Easy way to displaying, animating, and styling checkmark icon.

## Preview

[![Preview](https://github.com/davigmacode/flutter_animated_checkmark/raw/main/media/preview.gif)](https://davigmacode.github.io/flutter_animated_checkmark)

[Demo](https://davigmacode.github.io/flutter_animated_checkmark)

## Features

* Animated check/uncheck/undetermined by boolean value or double value.
* Animated color, weight, and size.
* Rounded or sharpen line style.
* Optionally draw cross for falsy value.
* Optionally undraw dash for undetermined value.

## Usage

For a complete usage, please see the [example](https://pub.dev/packages/animated_checkmark#-example-tab-).

To read more about classes and other references used by `animated_checkmark`, see the [API Reference](https://pub.dev/documentation/animated_checkmark/latest/).

```dart
// animate by value flag
AnimatedCheckmark(
  value: true,
  size: 12,
  color: Colors.blue,
  drawCross: true,
  drawDash: false,
);

// animate by progress value [-1.0 to 1.0]
Checkmark(
  progress: 0.5,
  weight: 2,
  size: const Size.square(12),
  color: Colors.blue,
  rounded: true,
);
```

## Sponsoring

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.