import 'package:ffi/ffi.dart';
import 'package:vs_ai_vision/vs_ai_vision.dart';

void getReadExpression() {
  final svmMethods = SVMFunctions();
  print(svmMethods.predictSample().toDartString());
}
