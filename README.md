# Moved

This repository is no longer used. The `flutter_image` package has moved to
[flutter/packages](https://github.com/flutter/packages/tree/master/packages/flutter_image).

---

# Image utilities for Flutter

## NetworkImageWithRetry

Use `NetworkImageWithRetry` instead of `Image.network` to load images from the
network with a retry mechanism.

Example:

```dart
var avatar = new Image(
  image: new NetworkImageWithRetry('http://example.com/avatars/123.jpg'),
);
```

The retry mechanism may be customized by supplying a custom `FetchStrategy`
function. `FetchStrategyBuilder` is a utility class that helps building fetch
strategy functions.

## Features and bugs

Please file feature requests and bugs at https://github.com/flutter/flutter/issues.
