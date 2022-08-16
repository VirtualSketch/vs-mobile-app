import 'dart:typed_data';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:virtual_sketch_app/utils/to_uint_8_list.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArcoreImageView extends StatefulWidget {
  const ArcoreImageView({Key? key, required this.imageUrl }) : super(key: key);

  final String imageUrl;

  @override
  State<ArcoreImageView> createState() => _ArcoreImageViewState();
}

class _ArcoreImageViewState extends State<ArcoreImageView> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return ArCoreView(onArCoreViewCreated: _onArCoreViewCreated);
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addImage(arCoreController);
  }

  void _addImage(ArCoreController controller) async {
    Uint8List imageBytes = await toUint8List(widget.imageUrl);
    final image = ArCoreImage(bytes: imageBytes, width: 5000, height: 5000 );

    final node = ArCoreNode(
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
