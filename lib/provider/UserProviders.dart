import 'package:flutter/material.dart';
import 'package:doctor_opinion/models/patient/User.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  List<User>? _users;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void updateUser(User updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  bool get isLoggedIn => _user != null;

  List<User>? get users => _users;

  void setUsers(List<User> users) {
    _users = users;
    notifyListeners();
  }

  void updateUserInList(User updatedUser) {
    if (_users != null) {
      int index = _users!.indexWhere((user) => user.id == updatedUser.id);
      if (index != -1) {
        _users![index] = updatedUser;
        notifyListeners();
      }
    }
  }

  void clearUsers() {
    _users = null;
    notifyListeners();
  }

  bool get hasUsers => _users != null && _users!.isNotEmpty;
}
