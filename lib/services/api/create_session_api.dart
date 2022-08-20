import 'package:dio/dio.dart';
import 'package:virtual_sketch_app/services/constants/endpoints.dart';
import 'package:virtual_sketch_app/services/dio_client.dart';

class CreateSessionApi {
  final DioClient dioClient;

  CreateSessionApi({required this.dioClient});

  Future<Response> createSession() async {
    try {
      final Response response = await dioClient.get(Endpoints.createSession);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
