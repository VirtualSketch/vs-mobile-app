import 'dart:typed_data';

import 'package:flutter/services.dart';

Future<Uint8List> toUint8List(String imageUrl) async {
  return (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl)).buffer.asUint8List();
}
