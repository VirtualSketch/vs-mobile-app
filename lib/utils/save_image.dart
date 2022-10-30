import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<Map<String, dynamic>> saveImage(
    Uint8List imageBytes, int h, int w) async {
  try {
    Directory appDocumentsDirectory = await getTemporaryDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/graph.jpg';

    File file = File(filePath);

    file.writeAsBytes(imageBytes);

    print(await file.exists());

    return {'path': filePath, 'file': file};
  } catch (e) {
    throw Exception(e);
  }
}
