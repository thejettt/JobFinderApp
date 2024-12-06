import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  User? _loggedInUser;

  List<User> get users => _users;
  User? get loggedInUser => _loggedInUser;

  void register(String username, String password) {
    _users.add(User(username: username, password: password));
    notifyListeners();
  }

  bool login(String username, String password) {
    for (User user in _users) {
      if (user.username == username && user.password == password) {
        _loggedInUser = user;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  void logout() {
    _loggedInUser = null;
    notifyListeners();
  }
}
