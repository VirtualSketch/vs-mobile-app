import 'package:virtual_sketch_app/model/equation_model.dart';

abstract class IGetEquation {
  Future<EquationModel> getEquation(String rawExpression);
}
