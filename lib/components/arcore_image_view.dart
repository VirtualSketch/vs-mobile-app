import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'dart:typed_data' as types;

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indexed/indexed.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:virtual_sketch_app/components/Dialog.dart';
import 'package:virtual_sketch_app/components/custom_close_button.dart';
import 'package:virtual_sketch_app/components/delimited_area.dart';
import 'package:virtual_sketch_app/utils/save_image.dart';
import 'package:virtual_sketch_app/utils/to_uint_8_list.dart';
import 'package:virtual_sketch_app/view_model/main_viewmodel.dart';
import 'package:vs_ai_vision/vs_ai_vision.dart';

// typedef Uint8ListPointer = ffi.Pointer<ffi.Uint8>;

// extension Uint8ListBlobConversion on Uint8List {
//   /// Allocates a pointer filled with the Uint8List data.
//   Uint8ListPointer allocatePointer() {
//     final blob = calloc<ffi.Uint8>(length);
//     final blobBytes = blob.asTypedList(length);
//     blobBytes.setAll(0, this);
//     return blob;
//   }
// }

class ArcoreImageView extends StatefulWidget {
  const ArcoreImageView({Key? key, this.imageUrl}) : super(key: key);

  final types.Uint8List? imageUrl;

  @override
  State<ArcoreImageView> createState() => _ArcoreImageViewState();
}

class _ArcoreImageViewState extends State<ArcoreImageView> {
  late ArCoreController arCoreController;
  final svm = SVMFunctions();

  types.Uint8List? imageBytes;
  String? texto;

  List<String> fromUtf16(ffi.Pointer<ffi.Uint8> ptr) {
    final units = <String>[];
    int len = 0;
    while (true) {
      final char = ptr.elementAt(len++).toString();
      if (char == 0) {
        break;
      }
      units.add(char);
    }
    return units;
  }

  Future<void> _handleScreenShot(
      BuildContext context, MainViewModel mainViewModel) async {
    try {
      types.Uint8List screen = await arCoreController.snapshot();
      arCoreController.loadSingleAugmentedImage(bytes: screen);

      var decodeImage = await decodeImageFromList(screen);

      String filePath = await saveImage(screen);

      print(screen);

      String expression =
          svm.predictWithPath(filePath.toNativeUtf8()).toDartString();

      String splitedExpression = expression.split('=')[1];

      showAlertDialog(context, 'A expressão esta correta?', expression,
          () => mainViewModel.resolveExpression(splitedExpression));
    } catch (_) {
      Fluttertoast.showToast(
          msg: 'Erro no reconhecimento da função.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final mainViewModel = Modular.get<MainViewModel>();

      return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF7A44EC),
            onPressed: () async {
              if (mainViewModel.currentImage != null) {
                arCoreController.removeNode(nodeName: 'image');
              }
              _handleScreenShot(context, mainViewModel);
            },
            child: const FaIcon(FontAwesomeIcons.camera),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SafeArea(
            child: Indexer(
              children: [
                Indexed(
                  index: 99,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: DelimitedArea(),
                        ),
                      ),
                    ),
                  ),
                ),
                Indexed(
                  index: 99,
                  child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: CustomCloseButton(
                          onClose: () => Modular.to.navigate('/'))),
                ),
                Column(
                  children: [
                    Expanded(
                      child: ArCoreView(
                        enableUpdateListener: true,
                        onArCoreViewCreated: (controller) =>
                            _onArCoreViewCreated(controller, mainViewModel),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ));
    });
  }

  void _onArCoreViewCreated(
      ArCoreController controller, MainViewModel viewModel) {
    arCoreController = controller;
    viewModel.setArController(controller);

    print('AR inicializado');

    // _addImage(arCoreController, viewModel);

    // arCoreController.onPlaneDetected = ((plane) {
    //   print('plane detectado');
    //   print(plane);

    //   Fluttertoast.showToast(
    //       msg: 'Plano encontrado',
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.TOP,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // });
  }

  void _addImage(ArCoreController controller, MainViewModel viewModel) async {
    if (viewModel.currentImage != null) {
      types.Uint8List imageBytes = toUint8List(viewModel.currentImage!);

      final image = ArCoreImage(bytes: imageBytes, width: 5000, height: 5000);

      final node = ArCoreNode(
        name: 'image',
        image: image,
        position: vector.Vector3(-0.5, -0.5, -3.5),
      );
      controller.addArCoreNode(node);
      // controller.loadSingleAugmentedImage(bytes: bytes)
      // controller.addArCoreNodeToAugmentedImage(node, index)
    }

    print('teste iniciado');

    // final material = ArCoreMaterial(
    //   color: const Color.fromARGB(120, 6, 215, 230),
    //   metallic: 1.0,
    // );
    // final cube = ArCoreCube(
    //   materials: [material],
    //   size: vector.Vector3(0.5, 0.5, 0.5),
    // );
    // final node = ArCoreNode(
    //   shape: cube,
    //   position: vector.Vector3(-0.5, 0.5, -3.5),
    // );
    // controller.addArCoreNode(node);

    final ByteData bytes = await rootBundle.load('assets/graph.png');
    final types.Uint8List list = bytes.buffer.asUint8List();
    final image = ArCoreImage(bytes: list, width: 5000, height: 5000);
    final node = ArCoreNode(
      name: 'image',
      image: image,
      position: vector.Vector3(-0.5, 0.5, -3.5),
      // position: vector.Vector3(0, 0, 0),
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
