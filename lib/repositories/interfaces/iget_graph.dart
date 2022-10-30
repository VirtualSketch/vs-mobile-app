import 'package:virtual_sketch_app/model/graph_model.dart';

abstract class IGetGraph {
  Future<GraphModel> getGraph(String rawExpression, String graphColor);
}
