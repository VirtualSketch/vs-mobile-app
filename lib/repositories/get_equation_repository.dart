import 'package:dio/dio.dart';
import 'package:virtual_sketch_app/model/equation_model.dart';
import 'package:virtual_sketch_app/repositories/interfaces/iget_equation.dart';
import 'package:virtual_sketch_app/services/api/get_equation_api.dart';
import 'package:virtual_sketch_app/services/dio_exceptions.dart';

class GetEquationRepository implements IGetEquation {
  final GetEquationApi getEquationApi;

  GetEquationRepository(this.getEquationApi);

  @override
  Future<EquationModel> getEquation(String rawExpression) async {
    try {
      final response = await getEquationApi.getEquation(rawExpression);
      final equation = EquationModel.fromJson(response.data);
      return equation;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
