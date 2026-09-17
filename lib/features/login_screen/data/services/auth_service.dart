import 'package:dio/dio.dart';
import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/dio_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/storage/token_storage.dart';
import '../../../register_screen/data/models/user_model.dart';

class AuthService {
  final ApiConsumer apiConsumer = DioConsumer();

  Future<UserModel> register({
    required String username,
    required String password,
    String? imagePath,
  }) async {
    final map = <String, dynamic>{
      'username': username,
      'password': password,
    };
    if (imagePath != null && imagePath.isNotEmpty) {
      map['image'] = await MultipartFile.fromFile(imagePath);
    }

    final response = await apiConsumer.post(
      EndPoints.register,
      data: map,
      isFormData: true,
    );

    if (response is Map<String, dynamic>) {
      final token = response['access_token'] ?? response['token'];
      final refresh = response['refresh_token'];
      if (token != null) {
        await TokenStorage.saveTokens(accessToken: token, refreshToken: refresh);
      }
      await TokenStorage.saveUsername(username);
      return UserModel.fromJson(response['user'] ?? response);
    }
    return UserModel(username: username);
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final response = await apiConsumer.post(
      EndPoints.login,
      data: {
        'username': username,
        'password': password,
      },
      isFormData: true,
    );

    if (response is Map<String, dynamic>) {
      final token = response['access_token'] ?? response['token'];
      final refresh = response['refresh_token'];
      if (token != null) {
        await TokenStorage.saveTokens(accessToken: token, refreshToken: refresh);
      }
      await TokenStorage.saveUsername(username);
    }
  }

  Future<UserModel> getUserData() async {
    final response = await apiConsumer.get(EndPoints.getUserData);
    if (response is Map<String, dynamic>) {
      return UserModel.fromJson(response['user'] ?? response);
    }
    final savedUsername = await TokenStorage.getUsername() ?? 'Ahmed Saber';
    return UserModel(username: savedUsername);
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await apiConsumer.post(
      EndPoints.changePassword,
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirm': confirmPassword,
      },
      isFormData: true,
    );
  }

  Future<void> updateProfile({
    required String username,
    String? imagePath,
  }) async {
    final map = <String, dynamic>{
      'username': username,
    };
    if (imagePath != null && imagePath.isNotEmpty) {
      map['image'] = await MultipartFile.fromFile(imagePath);
    }

    await apiConsumer.put(
      EndPoints.updateProfile,
      data: map,
      isFormData: true,
    );
    await TokenStorage.saveUsername(username);
  }

  Future<void> deleteUser() async {
    await apiConsumer.delete(EndPoints.deleteUser);
    await TokenStorage.clear();
  }
}
