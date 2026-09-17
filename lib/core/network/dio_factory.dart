import 'package:dio/dio.dart';
import 'end_points.dart';
import '../storage/token_storage.dart';

class DioFactory {
  static Dio? _dio;

  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: EndPoints.baseUrl,
          receiveTimeout: const Duration(seconds: 20),
          connectTimeout: const Duration(seconds: 20),
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      _dio!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final token = await TokenStorage.getAccessToken();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          },
          onError: (DioException error, handler) async {
            // Handle automatic token refresh if 401
            if (error.response?.statusCode == 401) {
              final refreshToken = await TokenStorage.getRefreshToken();
              if (refreshToken != null && refreshToken.isNotEmpty) {
                try {
                  final refreshResponse = await Dio(BaseOptions(baseUrl: EndPoints.baseUrl)).post(
                    EndPoints.refreshToken,
                    options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
                  );
                  final newAccessToken = refreshResponse.data['access_token'] ?? refreshResponse.data['token'];
                  if (newAccessToken != null) {
                    await TokenStorage.saveAccessToken(newAccessToken);
                    error.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
                    final retryResponse = await _dio!.fetch(error.requestOptions);
                    return handler.resolve(retryResponse);
                  }
                } catch (e) {
                  await TokenStorage.clear();
                }
              }
            }
            return handler.next(error);
          },
        ),
      );
    }
    return _dio!;
  }
}
