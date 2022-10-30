import 'dart:io';
import 'dart:typed_data';
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indexed/indexed.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:virtual_sketch_app/components/custom_close_button.dart';
import 'package:virtual_sketch_app/components/delimited_area.dart';
import 'package:virtual_sketch_app/utils/save_image.dart';
import 'package:virtual_sketch_app/utils/to_uint_8_list.dart';
import 'package:virtual_sketch_app/view_model/main_viewmodel.dart';
import 'package:vs_ai_vision/vs_ai_vision.dart';

typedef Uint8ListPointer = ffi.Pointer<ffi.Uint8>;

extension Uint8ListBlobConversion on Uint8List {
  /// Allocates a pointer filled with the Uint8List data.
  Uint8ListPointer allocatePointer() {
    final blob = calloc<ffi.Uint8>(length);
    final blobBytes = blob.asTypedList(length);
    blobBytes.setAll(0, this);
    return blob;
  }
}

class ArcoreImageView extends StatefulWidget {
  const ArcoreImageView({Key? key, this.imageUrl}) : super(key: key);

  final Uint8List? imageUrl;

  @override
  State<ArcoreImageView> createState() => _ArcoreImageViewState();
}

class _ArcoreImageViewState extends State<ArcoreImageView> {
  late ArCoreController arCoreController;
  final svmMethods = SVMFunctions();

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
      MainViewModel mainViewModel, double h, double w) async {
    Uint8List screen = await arCoreController.snapshot();
    var decodeImage = await decodeImageFromList(screen);

    var size = WidgetsBinding.instance.window.physicalSize;

    Map fileProps =
        await saveImage(screen, size.height.toInt(), size.width.toInt());

    String path = fileProps['path'] as String;
    File file = fileProps['file'] as File;

    // final result = await ImageGallerySaver.saveImage(screen, name: 'graph');
    // print('imagem salva');
    // print(result);

    print(screen);
    print('arquivo local');
    print(await file.exists());
    print(path);

    // print(await file.readAsBytes());

    // print('imagem decodificada');
    // print(screen);
    // print(await decodeImage.toByteData());

    Uint8ListPointer pointer =
        Uint8ListBlobConversion(screen).allocatePointer();

    // print(pointer.elementAt(0).value);

    // print('decode image');
    // print(decodeImage.height);
    // print(decodeImage.width);

    // Size size = WidgetsBinding.instance.window.physicalSize;
    // print('screen');
    // print(size.height);
    // print(size.width);

    // print(fromUtf16(pointer));

    // print('antes do predict');

    String expression = svmMethods
        // .predict(pointer, decodeImage.width, decodeImage.height)
        .predictWithPath(
            '/data/data/com.example.virtual_sketch_app/cache/graph.jpg'
                .toNativeUtf8())
        .toDartString();

    print('predict');
    print(expression);

    // mainViewModel.resolveExpression(expression);
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
              _handleScreenShot(
                  mainViewModel,
                  MediaQuery.of(context).size.height,
                  MediaQuery.of(context).size.width);
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
                        onArCoreViewCreated: (controller) =>
                            _onArCoreViewCreated(controller, mainViewModel),
                        type: ArCoreViewType.AUGMENTEDIMAGES,
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
    _addImage(arCoreController, viewModel);
  }

  void _addImage(ArCoreController controller, MainViewModel viewModel) async {
    if (viewModel.currentImage != null) {
      Uint8List imageBytes = await toUint8List(viewModel.currentImage!);

      final image = ArCoreImage(bytes: imageBytes, width: 5000, height: 5000);

      final node = ArCoreNode(
        name: 'image',
        image: image,
        position: vector.Vector3(-0.5, -0.5, -3.5),
      );
      controller.addArCoreNode(node);
    }
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
