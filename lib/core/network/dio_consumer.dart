import 'package:dio/dio.dart';
import 'api_consumer.dart';
import 'dio_factory.dart';

class DioConsumer implements ApiConsumer {
  final Dio client = DioFactory.getDio();

  @override
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<dynamic> post(String path, {dynamic data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    try {
      final response = await client.post(
        path,
        data: isFormData && data is Map<String, dynamic> ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<dynamic> put(String path, {dynamic data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    try {
      final response = await client.put(
        path,
        data: isFormData && data is Map<String, dynamic> ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<dynamic> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.delete(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException error) {
    if (error.response != null && error.response?.data != null) {
      final data = error.response!.data;
      if (data is Map && data.containsKey('message')) {
        return data['message'].toString();
      }
      return data.toString();
    }
    return error.message ?? "An unexpected error occurred";
  }
}
