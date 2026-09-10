import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_assets.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_fonts.dart';
import 'package:todo_app/core/widgets/custom_txt_field.dart';

import '../data/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // controllers for the text fields

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
// default selected group
  String _selectedGroup = 'Home';
  final List<Map<String, dynamic>> _groups = [
    {'name': 'Home', 'icon': Icons.home_outlined, 'color': Colors.pinkAccent},
    {
      'name': 'Personal',
      'icon': Icons.person_outline,
      'color': AppColors.primary
    },
    {'name': 'Work', 'icon': Icons.work_outline, 'color': Colors.black87},
  ];

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

      // App bar with a back button and title
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 18, color: AppColors.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Add Task', style: AppFonts.titleBold),
      ),

      // Body with a form to add a new task
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          children: [
            // 1- header image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                AppAssets.headerFlag,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // 2- title
            CustomTextField(controller: _titleController, hintText: 'Title'),
            const SizedBox(height: 14),

            // 3- description
            CustomTextField(
                controller: _descController,
                hintText: 'Description',
                maxLines: 3),
            const SizedBox(height: 14),

            // 4- group selection
            Container(
              // appearance of the dropdown
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.fieldFill,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.fieldBorder),
              ),

              // drop down
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedGroup,
                  isExpanded: true,
                  items: _groups.map((item) {
                    return DropdownMenuItem<String>(
                      value: item['name'],
                      child: Row(
                        children: [
                          Icon(item['icon'], color: item['color'], size: 20),
                          const SizedBox(width: 12),
                          Text(item['name'],
                              style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _selectedGroup = val!),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // 5- end time picker
            CustomTextField(
              controller: _timeController,
              hintText: 'End Time',
              prefixIcon: Icons.calendar_month_outlined,
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (date != null && mounted) {
                  _timeController.text =
                      "\${date.day}/\${date.month}/\${date.year} 10:00 PM";
                }
              },
            ),
            const SizedBox(height: 30),

            // 6- add task button
            SizedBox(
              // appearance of the button
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),

                // click action of the button
                onPressed: () {
                  if (_titleController.text.isNotEmpty) {
                    Navigator.pop(
                      context,
                      TaskModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: _titleController.text,
                        description: _descController.text,
                        group: _selectedGroup,
                        dateTime: _timeController.text.isNotEmpty
                            ? _timeController.text
                            : 'Today',
                      ),
                    );
                  }
                },

                // text of the button
                child: const Text('Add Task', style: AppFonts.buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
