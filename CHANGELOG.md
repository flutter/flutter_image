# Changelog

## 4.0.0

**Updates for Flutter 2.0.0**
- Introduces null safety
### Some public API changes
- **NetworkImageWithRetry**

  - **load(NetworkImageWithRetry key, DecoderCallback decode)**
    - Most important changes are related to this section, because it's the only place where some logic has been changed.
    - This method returns a `ImageStreamCompleter` that completes with the image to be loaded. It takes a `Future<ImageInfo>` from a helper( `_loadWithRetry`). Previously the _completer_ crashed when completed with _null_. To avoid this situation we made errors more explicit throwing them instead of returning nothing. See changes made to `_loadWithRetry`.

  - **_loadWithRetry(NetworkImageWithRetry key, DecoderCallback decode)**
    - Previously this helper returned _null_ when it wasn't possible to load the image, but now it throws an exception. In both cases there would be an error as there wouldn't be any image to be shown by Flutter. So, it _shouldn't_ be a __breaking change__.
    - The return type of this method has been changed from nullable to not nullable. It means that we must throw if it wasn't possible to load an image.
    - To summarize, we throw under 3 cases:
      1. When the http's statusCode is not 200.
      2. When the image received had 0 bytes.
      3. When under cases 1 and 2 there's no fallback image.
   
- **FetchStrategy** and **defaultFetchStrategy**
  - Make it so that `failure` is nullable. It means that a subsequent retry may or may not receive information about the previous attempt.
 
- **FetchInstructions**
  - Makes `timeout` defaults to zero to avoid being nullable.
  - Makes `alternativeImage` nullable as its mutually exclusive with timeout (one is only available/used when the other is not).

- **FetchFailure**
  - Make `httpStatusCode` nullable as a error may have been caused by something other than network issues.

- **TransientHttpStatusCodePredicate**
  - Make `statusCode` not nullable as it doesn't make sense to check if a request should be retried when there's no statusCode. In this case the check for null belongs to client, normally `FetchStrategyBuilder.build()`

- **Others**
  - Removed asserts of nullable checks

## 3.0.0

* **Breaking change**. Updates for Flutter 1.10.15.

## 2.0.1

- Update Flutter SDK version constraint.

## 2.0.0

* **Breaking change**. Updates for Flutter 1.5.9.

## 1.0.0

* **Breaking change**. SDK constraints to support Flutter beta versions and Dart 2 only.

## 0.0.3

- Moved `flutter_test` to dev_dependencies in `pubspec.yaml`, and fixed issues
flagged by the analyzer.

## 0.0.2

- Add `NetworkImageWithRetry`, an `ImageProvider` with a retry mechanism.

## 0.0.1

- Contains no useful code.
