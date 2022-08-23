import 'package:flutter_modular/flutter_modular.dart';
import 'package:virtual_sketch_app/repositories/create_session_repositiory.dart';
import 'package:virtual_sketch_app/repositories/get_equation_repository.dart';
import 'package:virtual_sketch_app/repositories/get_graph_repository.dart';
import 'package:virtual_sketch_app/repositories/kill_session_repository.dart';
import 'package:virtual_sketch_app/services/api/create_session_api.dart';
import 'package:virtual_sketch_app/services/api/get_equation_api.dart';
import 'package:virtual_sketch_app/services/api/get_graph_api.dart';
import 'package:virtual_sketch_app/services/api/kill_session_api.dart';
import 'package:virtual_sketch_app/services/dio_client.dart';
import 'package:virtual_sketch_app/view/home_view.dart';
import 'package:dio/dio.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => Dio()),
        Bind.singleton((i) => DioClient(Modular.get<Dio>())),
        Bind.singleton(
            (i) => CreateSessionApi(dioClient: Modular.get<DioClient>())),
        Bind.singleton((i) => GetGraphApi(dioClient: Modular.get<DioClient>())),
        Bind.singleton(
            (i) => GetEquationApi(dioClient: Modular.get<DioClient>())),
        Bind.singleton(
            (i) => KillSessionApi(dioClient: Modular.get<DioClient>())),
        Bind.singleton(
            (i) => CreateSessionRepository(Modular.get<CreateSessionApi>())),
        Bind.singleton((i) => GetGraphRepository(Modular.get<GetGraphApi>())),
        Bind.singleton(
            (i) => GetEquationRepository(Modular.get<GetEquationApi>())),
        Bind.singleton(
            (i) => KillSessionRepository(Modular.get<KillSessionApi>()))
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (context, args) => const HomePage())];
}
