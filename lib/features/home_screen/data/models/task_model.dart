class TaskModel {
  final String id;
  final String title;
  final String description;
  final String group;
  final String dateTime;
  final String? image;
  bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.group = 'Home',
    this.dateTime = 'Today',
    this.image,
    this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: (json['id'] ?? DateTime.now().millisecondsSinceEpoch).toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      group: json['group'] ?? 'Home',
      dateTime: json['date_time'] ?? json['created_at'] ?? 'Today',
      image: json['image'],
      isDone: json['is_done'] == true || json['status'] == 'done' || json['status'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'group': group,
      'date_time': dateTime,
      'image': image,
      'is_done': isDone,
    };
  }
}
