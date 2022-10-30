import 'dart:typed_data';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:virtual_sketch_app/repositories/get_equation_repository.dart';
import 'package:virtual_sketch_app/repositories/get_graph_repository.dart';

part 'main_viewmodel.g.dart';

class MainViewModel = MainViewModelBase with _$MainViewModel;

abstract class MainViewModelBase with Store {
  @observable
  String? currentImage;

  @observable
  List<Map<String, dynamic>?> resolvedExpressions = [];

  @action
  void setCurrentImage(String base64Image) {
    currentImage = base64Image;
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
  Future<void> resolveExpression(String expression) async {
    final equationResult =
        await Modular.get<GetEquationRepository>().getEquation(expression);

    final graphImageResult =
        await Modular.get<GetGraphRepository>().getGraph(expression, '#fff');

    setCurrentImage(graphImageResult.graphBase64Image);
    setResolvedExpressions(
        equationResult.equation, graphImageResult.graphBase64Image, expression);
  }
}
