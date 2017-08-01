// Copyright (c) 2017, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class TestImageProvider extends ImageProvider<TestImageProvider> {
  TestImageProvider(this.testImage);

  final ui.Image testImage;

  final Completer<ImageInfo> _completer = new Completer<ImageInfo>.sync();
  ImageConfiguration configuration;

  @override
  Future<TestImageProvider> obtainKey(ImageConfiguration configuration) {
    return new SynchronousFuture<TestImageProvider>(this);
  }

  @override
  ImageStream resolve(ImageConfiguration config) {
    configuration = config;
    return super.resolve(configuration);
  }

  @override
  ImageStreamCompleter load(TestImageProvider key) =>
      new OneFrameImageStreamCompleter(_completer.future);

  void complete() {
    _completer.complete(new ImageInfo(image: testImage));
  }

  @override
  String toString() => '${describeIdentity(this)}()';
}

Future<ui.Image> createTestImage() {
  final Completer<ui.Image> uiImage = new Completer<ui.Image>();
  ui.decodeImageFromList(kTransparentImage, uiImage.complete);
  return uiImage.future;
}

final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49,
  0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06,
  0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44,
  0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D,
  0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
]);
