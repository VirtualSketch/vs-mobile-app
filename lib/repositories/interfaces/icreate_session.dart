import 'package:virtual_sketch_app/model/create_session_model.dart';

abstract class ICreateSession {
  Future<CreateSessionModel> createSession();
}
