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

      // طباعة الـ Requests والـ Headers في الـ Terminal لمعاينة التوكن
      _dio!.interceptors.add(
        LogInterceptor(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
        ),
      );

      _dio!.interceptors.add(
        QueuedInterceptorsWrapper(
          onRequest: (options, handler) async {
            // قراءة التوكن من الذاكرة
            final token = await TokenStorage.getAccessToken();

            // تحقق وطباعة في الكونسول للتأكد
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          },
          onError: (DioException error, handler) async {
            // التعامل مع انتهاء الصلاحية 401
            if (error.response?.statusCode == 401) {
              final refreshToken = await TokenStorage.getRefreshToken();
              if (refreshToken != null && refreshToken.isNotEmpty) {
                try {
                  final refreshDio =
                      Dio(BaseOptions(baseUrl: EndPoints.baseUrl));
                  final refreshResponse = await refreshDio.post(
                    EndPoints.refreshToken,
                    options: Options(
                      headers: {'Authorization': 'Bearer $refreshToken'},
                    ),
                  );

                  final data = refreshResponse.data;
                  final newAccessToken = data['access_token'] ??
                      data['token'] ??
                      data['data']?['token'];

                  if (newAccessToken != null) {
                    await TokenStorage.saveAccessToken(
                        newAccessToken.toString());

                    // تحديث الهيدر للطلب الأصلي وإعادة تنفيذه
                    error.requestOptions.headers['Authorization'] =
                        'Bearer $newAccessToken';
                    final retryResponse =
                        await _dio!.fetch(error.requestOptions);
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
