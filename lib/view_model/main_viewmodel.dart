import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    final countItems = resolvedExpressions.length;
    try {
      final equationResult =
          await Modular.get<GetEquationRepository>().getEquation(expression);

      final graphImageResult =
          await Modular.get<GetGraphRepository>().getGraph(expression, '#000');

      setCurrentImage(graphImageResult.graphBase64Image);
      setResolvedExpressions(equationResult.equation,
          graphImageResult.graphBase64Image, expression);
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
