import 'package:dio/dio.dart';
import 'package:virtual_sketch_app/repositories/interfaces/Ikill_session.dart';
import 'package:virtual_sketch_app/services/api/kill_session_api.dart';
import 'package:virtual_sketch_app/services/dio_exceptions.dart';

class KillSessionRepository implements IKillSession {
  final KillSessionApi killSessionApi;

  KillSessionRepository(this.killSessionApi);

  @override
  Future<int?> killSession(String sessionId) async {
    try {
      final response = await killSessionApi.killSession(sessionId);
      final statusCode = response.statusCode;
      return statusCode;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
