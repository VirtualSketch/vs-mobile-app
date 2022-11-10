import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:virtual_sketch_app/services/dio_client.dart';
import 'package:virtual_sketch_app/services/api/api.dart';
import 'package:virtual_sketch_app/repositories/repositories.dart';
import 'package:virtual_sketch_app/view/ar_camera_view.dart';
import 'package:virtual_sketch_app/view/home_view.dart';
import 'package:virtual_sketch_app/view/result_view.dart';
import 'package:virtual_sketch_app/view_model/main_viewmodel.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => Dio()),
        Bind.singleton((i) => DioClient(Modular.get<Dio>())),
        Bind.singleton((i) => GetGraphApi(dioClient: Modular.get<DioClient>())),
        Bind.singleton(
            (i) => GetEquationApi(dioClient: Modular.get<DioClient>())),
        Bind.singleton(
            (i) => KillSessionApi(dioClient: Modular.get<DioClient>())),
        Bind.singleton((i) => GetGraphRepository(Modular.get<GetGraphApi>())),
        Bind.singleton(
            (i) => GetEquationRepository(Modular.get<GetEquationApi>())),
        Bind.singleton(
            (i) => KillSessionRepository(Modular.get<KillSessionApi>())),
        Bind.singleton((i) => MainViewModel())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
        ChildRoute('/camera', child: (context, args) => const ArCameraView()),
        ChildRoute('/result',
            child: (context, args) => ResultView(
                imageBytes: args.data['image'],
                equationSteps: args.data['equation'])),
      ];
}
