import 'database_helper.dart';
import 'user_model.dart';

class UserData {
  static final List<UserModel> users = [];

  // Load users from database
  static Future<void> loadUsers() async {
    final data = await DatabaseHelper.instance.getUsers();

    users
      ..clear()
      ..addAll(data);
  }

  // Add user to database and local list
  static Future<void> addUser(UserModel user) async {
    final id = await DatabaseHelper.instance.insertUser(user);

    user.id = id;
    users.add(user);
  }

  // Update user in database and local list
  static Future<void> updateUser(UserModel user) async {
    await DatabaseHelper.instance.updateUser(user);

    final index = users.indexWhere((item) => item.id == user.id);

    if (index != -1) {
      users[index] = user;
    }
  }

  // Delete user from database and local list
  static Future<void> deleteUser(int id) async {
    await DatabaseHelper.instance.deleteUser(id);

    users.removeWhere((user) => user.id == id);
  }
}