import 'package:dio/dio.dart';
import 'package:virtual_sketch_app/services/constants/endpoints.dart';
import 'package:virtual_sketch_app/services/dio_client.dart';

class KillSessionApi {
  final DioClient dioClient;

  KillSessionApi({required this.dioClient});

  Future<Response> killSession(String sessionId) async {
    try {
      final response =
          await dioClient.get('${Endpoints.killSession}/$sessionId');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
