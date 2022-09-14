import 'dart:typed_data';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:virtual_sketch_app/utils/to_uint_8_list.dart';
import 'package:virtual_sketch_app/view_model/main_viewmodel.dart';

class ArcoreImageView extends StatefulWidget {
  const ArcoreImageView({Key? key, this.imageUrl}) : super(key: key);

  final Uint8List? imageUrl;

  @override
  State<ArcoreImageView> createState() => _ArcoreImageViewState();
}

class _ArcoreImageViewState extends State<ArcoreImageView> {
  late ArCoreController arCoreController;
  Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final mainViewModel = Modular.get<MainViewModel>();

      return Scaffold(
          appBar: AppBar(title: const Text('Screenshot')),
          floatingActionButton: FloatingActionButton(onPressed: () async {
            // final image = await arCoreController.takeScreenshot();
            // final view = await arCoreController.getView();
            // final view = await arCoreController.getLog();
            // final path = await arCoreController.snapshot();
            mainViewModel.takeSnapshot();
            print('Path da imagem');
            // print(path);

            // setState(() {
            //   imageBytes = path;
            // });
          }),
          body: Column(
            children: [
              Expanded(
                child: ArCoreView(
                  // onArCoreViewCreated: _onArCoreViewCreated,
                  onArCoreViewCreated: (controller) =>
                      _onArCoreViewCreated(controller, mainViewModel),
                  type: ArCoreViewType.AUGMENTEDIMAGES,
                  enableTapRecognizer: true,
                  enableUpdateListener: true,
                ),
              ),
              SizedBox(
                height: 200,
                child: mainViewModel.currentImageBytes != null
                    ? Image.memory(mainViewModel.currentImageBytes!)
                    : Image.network(
                        'https://media.istockphoto.com/photos/mountain-landscape-picture-id517188688?k=20&m=517188688&s=612x612&w=0&h=i38qBm2P-6V4vZVEaMy_TaTEaoCMkYhvLCysE7yJQ5Q='),
              )
            ],
          ));
    });
  }

  void _onArCoreViewCreated(
      ArCoreController controller, MainViewModel viewModel) {
    arCoreController = controller;
    viewModel.setArcoreController(controller);

    print(widget.imageUrl);

    // if (widget.imageUrl != null) {
    //   print('Entrou no if');
    //   _addImage(arCoreController);
    // }
    _addImage(viewModel.arCoreController!);
    // _addImage(arCoreController);
    // if (viewModel.arCoreController != null) {
    //   try {
    //     _addImage(viewModel.arCoreController!);
    //   } catch (e) {
    //     throw Error();
    //   }
    // }
  }

  void _addImage(ArCoreController controller) async {
    Uint8List imageBytes = await toUint8List(
        'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzV8fHBlcnNvbnxlbnwwfHwwfHw%3D&w=1000&q=80');
    print('func iniciada');
    final image = ArCoreImage(bytes: imageBytes, width: 5000, height: 5000);

    final node = ArCoreNode(
      name: 'image',
      image: image,
      position: vector.Vector3(-0.5, -0.5, -3.5),
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
