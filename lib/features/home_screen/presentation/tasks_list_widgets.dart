import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../data/models/task_model.dart';
import 'task_card_item.dart';

class TasksListWidgets extends StatelessWidget {
  final List<TaskModel> tasks;
  final Function(TaskModel) onTaskTap;

  const TasksListWidgets({
    super.key,
    required this.tasks,
    required this.onTaskTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      children: [
        Row(
          children: [
            const Text(
              'Tasks',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textBlack),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${tasks.length}',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...tasks.map((task) => TaskCardItem(
              task: task,
              onTap: () => onTaskTap(task),
            )),
      ],
    );
  }
}
