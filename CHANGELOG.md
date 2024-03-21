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
