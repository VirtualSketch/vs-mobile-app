import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<String> saveImage(Uint8List imageBytes) async {
  try {
    Directory appDocumentsDirectory = await getTemporaryDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/graph.jpg';

    File file = File(filePath);

    await file.writeAsBytes(imageBytes);

    return filePath;
  } catch (e) {
    throw Exception(e);
  }
}
