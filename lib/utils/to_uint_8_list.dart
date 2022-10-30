import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';

Future<Uint8List> toUint8List(String imageUrl) async {
  Uint8List imageBytes = base64.decode(imageUrl).buffer.asUint8List();
  return imageBytes;
}
