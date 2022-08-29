import 'package:dio/dio.dart';
import 'package:virtual_sketch_app/services/constants/endpoints.dart';
import 'package:virtual_sketch_app/services/dio_client.dart';

class GetEquationApi {
  final DioClient dioClient;

  GetEquationApi({required this.dioClient});

  Future<Response> getEquation(String rawExpression) async {
    try {
      final Response response = await dioClient
          .post(Endpoints.getEquation, data: {'raw_expression': rawExpression});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
