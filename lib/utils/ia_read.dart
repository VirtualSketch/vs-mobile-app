import 'package:ffi/ffi.dart';
import 'package:vs_ai_vision/vs_ai_vision.dart';

void getReadExpression() {
  final svmMethods = SVMFunctions();
  // print(svmMethods.predictSample().toDartString());
  print(svmMethods
      .predictWithPath(
          '/data/data/com.example.virtual_sketch_app/cache/graph.jpg'
              .toNativeUtf8())
      .toDartString());
}
