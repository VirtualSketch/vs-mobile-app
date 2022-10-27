import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:virtual_sketch_app/app/app_module.dart';
import 'package:virtual_sketch_app/app/app_widget.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  downloadExpression2jpg();
}

// Temporary code to download image
Future<String> get _localPath async {
  final directory = await getTemporaryDirectory();
  return directory.path;
}

void downloadExpression2jpg() async {
  Directory saveDir = Directory(await _localPath);
  String savePath = saveDir.path;
  String githubImageUrl =
      'https://github.com/VirtualSketch/vs-ai-vision/raw/path-test/lib/src/svm/assets/expression2.jpg';
  String githubTrainedData =
      'https://github.com/VirtualSketch/vs-ai-vision/raw/path-test/lib/src/svm/assets/trainedData.yml';

  try {
    await Dio().download(githubImageUrl, '$savePath/expression2.jpg',
        onReceiveProgress: (received, total) {
      if (total != -1) {
        print('${(received / total * 100).toStringAsFixed(0)}%');
        //you can build progressbar feature too
      }
    });
    await Dio().download(githubTrainedData, '$savePath/trainedData.yml',
        onReceiveProgress: (received, total) {
      if (total != -1) {
        print('${(received / total * 100).toStringAsFixed(0)}%');
        //you can build progressbar feature too
      }
    });
    print('Files have been saved successfully to $savePath.');
  } on DioError catch (e) {
    print(e.message);
  }
}
