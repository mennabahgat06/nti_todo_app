class EndPoints {
  // Update with your remote server IP or base URL
  static const String baseUrl =
      "https://ntitodo-production-8a7f.up.railway.app/api/";

  // Users / Auth
  static const String register = "register";
  static const String login = "login";
  static const String refreshToken = "refresh_token";
  static const String changePassword = "change_password";
  static const String updateProfile = "update_profile";
  static const String getUserData = "get_user_data";
  static const String deleteUser = "delete_user";

  // Tasks
  static const String newTask = "new_task";
  static const String myTasks = "my_tasks";
  static const String tasks = "tasks"; // /tasks/{id} for update & delete
}
