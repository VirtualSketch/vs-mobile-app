import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:virtual_sketch_app/services/constants/dio_base_options.dart';

@Injectable()
class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = DioBaseOptions.baseUrl
      ..options.connectTimeout = DioBaseOptions.connectionTimeout
      ..options.receiveTimeout = DioBaseOptions.receiveTimeout
      ..options.responseType = ResponseType.json;
  }

  Future<Response> get(String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
}) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
      String url, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
}) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
      String url, {
        data,
        Map<String, dynamic>? querParameters,
        Options?  options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
}) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: querParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}






