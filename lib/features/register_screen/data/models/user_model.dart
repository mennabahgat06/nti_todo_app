class UserModel {
  final int? id;
  final String username;
  final String? image;

  UserModel({
    this.id,
    required this.username,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      username: json['username'] ?? '',
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'image': image,
    };
  }
}
