## 3.1.0

* Added option to remove space when there is nothing to draw

## 3.0.0

* Renamed Checkmark to RawCheckmark
* Renamed AnimatedCheckmark to Checkmark
* Customizable using inherited theme

## 2.2.1

* Use `StrokeCap.square` instead of `StrokeCap.butt` for sharpen style.
* Adjust stroke inset.

## 2.2.0

* Added option to draw cross and optionally draw dash.

## 2.1.0

* Improved api doc
* Improved animated default value
* Updated sdk constraints
* Split into src files
* Update workspace flutter version to 3.22
* Added loader and wasm build for example web page

## 2.0.1

* Removed screenshots and example from package archive

## 2.0.0

* Replaced the `style` enumeration with a simpler `rounded` boolean property.
* The `size` property type has been changed from `Size` to `double`. This assumes the checkmark will always be displayed in a square format.
* The new default value for `weight` is `size` divided by `5`.
* The `active` property has been renamed to `value` and can now be `null`, indicating an undetermined state. This change affects the way dashes are drawn.

## 1.0.1

* Change license.

## 1.0.0

* Initial release.
* Animated show/hide by active flag or progress value.
* Animated color, weight, and size.
* Sharp or round style.
