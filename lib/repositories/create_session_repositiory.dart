import 'package:dio/dio.dart';
import 'package:virtual_sketch_app/model/create_session_model.dart';
import 'package:virtual_sketch_app/repositories/interfaces/icreate_session.dart';
import 'package:virtual_sketch_app/services/api/create_session_api.dart';
import 'package:virtual_sketch_app/services/dio_exceptions.dart';

class CreateSessionRepository implements ICreateSession {
  final CreateSessionApi createSessionApi;

  CreateSessionRepository(this.createSessionApi);

  @override
  Future<CreateSessionModel> createSession() async {
    try {
      final response = await createSessionApi.createSession();
      final session = CreateSessionModel.fromJson(response.data);
      return session;
    } on DioError catch (e) {
     final errorMessage = DioExceptions.fromDioError(e).toString();
     throw errorMessage;
    }
  }
}
