class TaskModel {
  final String id;
  final String title;
  final String description;
  final String group;
  final String dateTime;
  bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.group,
    required this.dateTime,
    this.isDone = false,
  });
}
