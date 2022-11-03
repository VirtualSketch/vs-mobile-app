import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:virtual_sketch_app/repositories/get_equation_repository.dart';
import 'package:virtual_sketch_app/repositories/get_graph_repository.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:virtual_sketch_app/utils/to_uint_8_list.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

part 'main_viewmodel.g.dart';

class MainViewModel = MainViewModelBase with _$MainViewModel;

abstract class MainViewModelBase with Store {
  @observable
  ArCoreController? arController;

  @observable
  String? currentImage;

  @observable
  List<Map<String, dynamic>?> resolvedExpressions = [];

  @action
  void setCurrentImage(String base64Image) {
    currentImage = base64Image;
  }

  @action
  void setArController(ArCoreController controller) {
    Fluttertoast.showToast(
        msg: 'controller adicionado',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    arController = controller;
  }

  @action
  void setResolvedExpressions(
      List<String> equation, String image, String expression) {
    Map<String, dynamic> data = {
      'expression': expression,
      'equation': equation,
      'image': image
    };

    resolvedExpressions.add(data);
  }

  @action
  Future<void> renderArImage() async {
    // arController?.onTrackingImage = (ArCoreAugmentedImage augmentedImage) {
    //   Uint8List imageBytes = toUint8List(currentImage!);
    //   final image = ArCoreImage(bytes: imageBytes, width: 5000, height: 5000);

    //   final node = ArCoreNode(
    //     name: 'image',
    //     image: image,
    //     position: vector.Vector3(-0.5, -0.5, -3.5),
    //   );
    //   arController?.addArCoreNode(node);

    //   Fluttertoast.showToast(
    //       msg: 'Node adicionado',
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.TOP,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    //   arController?.addArCoreNodeToAugmentedImage(node, augmentedImage.index);
    // };

    Uint8List imageBytes = toUint8List(currentImage!);
    final image = ArCoreImage(bytes: imageBytes, width: 5000, height: 5000);

    final node = ArCoreNode(
      name: 'image',
      image: image,
      position: vector.Vector3(-0.5, -0.5, -3.5),
    );
    arController?.addArCoreNode(node);

    Fluttertoast.showToast(
        msg: 'Node ${arController!.id.toString()} adicionado',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @action
  Future<void> resolveExpression(String expression) async {
    final countItems = resolvedExpressions.length;
    final prevImage = currentImage;

    try {
      final equationResult =
          await Modular.get<GetEquationRepository>().getEquation(expression);

      final graphImageResult =
          await Modular.get<GetGraphRepository>().getGraph(expression, '#000');

      setCurrentImage(graphImageResult.graphBase64Image);
      setResolvedExpressions(equationResult.equation,
          graphImageResult.graphBase64Image, expression);

      if (prevImage != null) {
        arController?.removeNode(nodeName: 'image');
      }

      await renderArImage();
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Falha ao tentar resolver a expressão. Tente novamente.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
