import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';

Uint8List toUint8List(String imageUrl) {
  Uint8List imageBytes = base64.decode(imageUrl).buffer.asUint8List();
  return imageBytes;
}
