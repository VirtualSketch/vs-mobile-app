import 'dart:typed_data';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:mobx/mobx.dart';

part 'main_viewmodel.g.dart';

class MainViewModel = MainViewModelBase with _$MainViewModel;

abstract class MainViewModelBase with Store {
  // @observable
  // late ArCoreController arCoreController;

  @observable
  ArCoreController? arCoreController;

  @observable
  Uint8List? currentImageBytes;

  @action
  void setArcoreController(ArCoreController controller) {
    arCoreController = controller;
  }

  @action
  void setCurrentImageBytes(Uint8List imageBytes) {
    currentImageBytes = imageBytes;
  }

  @action
  Future<void> takeSnapshot() async {
    final image = await arCoreController!.snapshot();
    currentImageBytes = image;
  }
}
