import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_assets.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_fonts.dart';
import 'package:todo_app/features/home_screen/data/models/task_model.dart';
import 'package:todo_app/features/home_screen/presentation/add_task_screen.dart';
import 'package:todo_app/features/home_screen/presentation/edit_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TaskModel> _tasks = [
    TaskModel(
      id: '1',
      title: 'My First Task',
      description: 'Improve my English skills by trying to speak',
      group: 'Personal',
      dateTime: '11/03/2025 05:00 PM',
    ),
    TaskModel(
      id: '2',
      title: 'My First Task',
      description: 'Improve my English skills by trying to speak',
      group: 'Home',
      dateTime: '11/03/2025 05:00 PM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage(AppAssets.headerFlag),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello!',
                          style: AppFonts.bodyRegular.copyWith(fontSize: 12)),
                      Text('Ahmed Saber',
                          style: AppFonts.titleBold.copyWith(fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: _tasks.isEmpty ? _buildEmptyState() : _buildTaskList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () async {
          final newTask = await Navigator.push<TaskModel>(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
          if (newTask != null) {
            setState(() => _tasks.add(newTask));
          }
        },
        child: const Icon(Icons.note_add_outlined, color: AppColors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'There are no tasks yet,\nPress the button\nTo add New Task',
            textAlign: TextAlign.center,
            style: AppFonts.bodyRegular,
          ),
          const SizedBox(height: 24),
          Image.asset(AppAssets.emptyTasksIllustration, height: 210),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      children: [
        Row(
          children: [
            const Text(
              'Tasks',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlack),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '\${_tasks.length}',
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ..._tasks.map((task) => _buildTaskCard(task)).toList(),
      ],
    );
  }

  Widget _buildTaskCard(TaskModel task) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditTaskScreen(task: task)),
        );
        if (result == 'delete') {
          setState(() => _tasks.removeWhere((item) => item.id == task.id));
        } else {
          setState(() {});
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardGreen,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack),
                ),
                Text(
                  task.dateTime,
                  style:
                      const TextStyle(fontSize: 11, color: AppColors.textGrey),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              task.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: AppColors.textBlack),
            ),
          ],
        ),
      ),
    );
  }
}
