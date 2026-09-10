import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_assets.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_fonts.dart';
import 'package:todo_app/core/widgets/custom_txt_field.dart';
import '../data/models/task_model.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _timeController;
  late String _selectedGroup;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descController = TextEditingController(text: widget.task.description);
    _timeController = TextEditingController(text: widget.task.dateTime);
    _selectedGroup = widget.task.group;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 18, color: AppColors.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Edit Task', style: AppFonts.titleBold),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              ),
              onPressed: () => Navigator.pop(context, 'delete'),
              icon: const Icon(Icons.delete_outline,
                  color: AppColors.white, size: 14),
              label: const Text('Delete',
                  style: TextStyle(color: AppColors.white, fontSize: 11)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage(AppAssets.headerFlag),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.isDone ? 'Done' : 'In Progress',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      widget.task.isDone
                          ? 'Congrats!'
                          : 'Believe you can, and you\'re halfway there.',
                      style: AppFonts.bodyRegular.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.fieldFill,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.fieldBorder),
              ),
              child: Row(
                children: [
                  const Icon(Icons.home_outlined,
                      color: Colors.pinkAccent, size: 20),
                  const SizedBox(width: 12),
                  Text(_selectedGroup, style: const TextStyle(fontSize: 14)),
                  const Spacer(),
                  const Icon(Icons.keyboard_arrow_down,
                      color: AppColors.textGrey),
                ],
              ),
            ),
            const SizedBox(height: 14),
            CustomTextField(
                controller: _titleController, hintText: 'Title', maxLines: 1),
            const SizedBox(height: 14),
            CustomTextField(
                controller: _descController,
                hintText: 'Description',
                maxLines: 4),
            const SizedBox(height: 14),
            CustomTextField(
              controller: _timeController,
              hintText: 'End Time',
              prefixIcon: Icons.calendar_month_outlined,
              readOnly: true,
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                onPressed: () {
                  setState(() => widget.task.isDone = true);
                },
                child: const Text('Mark as Done', style: AppFonts.buttonText),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                onPressed: () {
                  widget.task.isDone = widget.task.isDone;
                  Navigator.pop(context);
                },
                child: const Text(
                  'Update',
                  style: TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
