import 'package:dio/dio.dart';
import 'package:virtual_sketch_app/model/graph_model.dart';
import 'package:virtual_sketch_app/repositories/interfaces/iget_graph.dart';
import 'package:virtual_sketch_app/services/api/get_graph_api.dart';
import 'package:virtual_sketch_app/services/dio_exceptions.dart';

class GetGraphRepository implements IGetGraph {
  final GetGraphApi getGraphApi;

  GetGraphRepository(this.getGraphApi);

  @override
  Future<GraphModel> getGraph(String rawExpression, String graphColor) async {
    try {
      final response = await getGraphApi.getGraph(rawExpression, graphColor);
      final graph = GraphModel.fromJson(response.data);
      return graph;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
