import 'package:flutter_modular/flutter_modular.dart';
import 'package:virtual_sketch_app/view/home_view.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (context, args) => const HomePage())];
}
