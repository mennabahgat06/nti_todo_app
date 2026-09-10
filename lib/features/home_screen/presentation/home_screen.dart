import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_assets.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_fonts.dart';
import 'package:todo_app/features/home_screen/data/models/task_model.dart';
import 'package:todo_app/features/home_screen/presentation/add_task_screen.dart';
import 'package:todo_app/features/home_screen/presentation/edit_task_screen.dart';
import 'package:todo_app/features/home_screen/presentation/empty_task_widget.dart';
import 'package:todo_app/features/home_screen/presentation/tasks_list_widgets.dart';

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
            // main content
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),

              /// ******************* 1- Header  *******************************

              // 1- avatar
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage(AppAssets.headerFlag),
                  ),
                  const SizedBox(width: 12),

                  // 2- user info

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

            // ******************* 2- Tasks List  *******************************
            Expanded(
              child: _tasks.isEmpty
                  ? const EmptyTasksWidget()
                  : TasksListWidget(
                      tasks: _tasks,
                      onTaskTap: (task) async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTaskScreen(task: task),
                          ),
                        );

                        if (result == 'delete') {
                          setState(() =>
                              _tasks.removeWhere((item) => item.id == task.id));
                        } else {
                          setState(() {});
                        }
                      },
                    ),
            ),
          ],
        ),
      ),

      // ******************* 3- Add Task Button  *******************************

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
}
