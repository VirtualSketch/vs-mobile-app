import 'package:vs_ai_vision/vs_ai_vision.dart';
import 'package:ffi/ffi.dart';

void getReadExpression() {
  final svmMethods = SVMFunctions();
  print(svmMethods.predict().toDartString());
}
