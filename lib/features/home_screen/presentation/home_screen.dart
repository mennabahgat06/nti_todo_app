import 'package:flutter/material.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/storage/token_storage.dart';
import '../../profile_screen/presentation/profile_screen.dart';
import '../data/models/task_model.dart';
import '../data/services/task_service.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';
import 'empty_task_widget.dart';
import 'tasks_list_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskService _taskService = TaskService();
  List<TaskModel> _tasks = [];
  bool _isLoading = false;
  String _displayName = 'Ahmed Saber';

  @override
  void initState() {
    super.initState();
    _loadUserAndTasks();
  }

  Future<void> _loadUserAndTasks() async {
    final name = await TokenStorage.getUsername();
    if (name != null && name.isNotEmpty) {
      setState(() => _displayName = name);
    }
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    setState(() => _isLoading = true);
    final list = await _taskService.getMyTasks();
    if (mounted) {
      setState(() {
        _tasks = list;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                      _loadUserAndTasks();
                    },
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage(AppAssets.flagPng),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                      _loadUserAndTasks();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello!', style: AppFonts.bodyRegular.copyWith(fontSize: 12)),
                        Text(_displayName, style: AppFonts.titleBold.copyWith(fontSize: 15)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.refresh, color: AppColors.primary),
                    onPressed: _fetchTasks,
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                  : _tasks.isEmpty
                      ? const EmptyTaskWidget()
                      : TasksListWidgets(
                          tasks: _tasks,
                          onTaskTap: (task) async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditTaskScreen(task: task)),
                            );
                            if (result == 'refresh' || result == 'delete') {
                              _fetchTasks();
                            }
                          },
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () async {
          final added = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
          if (added == true) {
            _fetchTasks();
          }
        },
        child: const Icon(Icons.note_add_outlined, color: AppColors.white),
      ),
    );
  }
}
