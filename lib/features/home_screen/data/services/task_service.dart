import 'package:dio/dio.dart';
import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/dio_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../models/task_model.dart';

class TaskService {
  final ApiConsumer apiConsumer = DioConsumer();

  Future<List<TaskModel>> getMyTasks() async {
    try {
      final response = await apiConsumer.get(EndPoints.myTasks);
      if (response is List) {
        return response.map((item) => TaskModel.fromJson(item as Map<String, dynamic>)).toList();
      } else if (response is Map<String, dynamic> && response['tasks'] is List) {
        return (response['tasks'] as List)
            .map((item) => TaskModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<TaskModel> newTask({
    required String title,
    required String description,
    String? imagePath,
  }) async {
    final map = <String, dynamic>{
      'title': title,
      'description': description,
    };
    if (imagePath != null && imagePath.isNotEmpty) {
      map['image'] = await MultipartFile.fromFile(imagePath);
    }

    final response = await apiConsumer.post(
      EndPoints.newTask,
      data: map,
      isFormData: true,
    );

    if (response is Map<String, dynamic>) {
      return TaskModel.fromJson(response['task'] ?? response);
    }
    return TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
    );
  }

  Future<void> updateTask({
    required String id,
    required String title,
    required String description,
    String? imagePath,
  }) async {
    final map = <String, dynamic>{
      'title': title,
      'description': description,
    };
    if (imagePath != null && imagePath.isNotEmpty) {
      map['image'] = await MultipartFile.fromFile(imagePath);
    }

    await apiConsumer.put(
      "${EndPoints.tasks}/$id",
      data: map,
      isFormData: true,
    );
  }

  Future<void> deleteTask(String id) async {
    await apiConsumer.delete("${EndPoints.tasks}/$id");
  }
}
