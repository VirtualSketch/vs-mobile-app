import 'package:dio/dio.dart';
import 'package:virtual_sketch_app/services/constants/endpoints.dart';
import 'package:virtual_sketch_app/services/dio_client.dart';

class GetGraphApi {
  final DioClient dioClient;

  GetGraphApi({required this.dioClient});

  Future<Response> getGraph(
      String sessionId, String rawExpression, String graphColor) async {
    try {
      final Response response = await dioClient.post(Endpoints.getGraph, data: {
        'session_id': sessionId,
        'raw_expression': rawExpression,
        'graph_color': graphColor
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
