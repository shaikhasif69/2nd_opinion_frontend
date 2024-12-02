// import 'package:flutter/material.dart';
// import 'package:doctor_opinion/models/patient/User.dart';

// class UserProvider with ChangeNotifier {
//   User? _user;
//   List<User>? _users;

//   User? get user => _user;

//   void setUser(User user) {
//     _user = user;
//     notifyListeners();
//   }

//   void updateUser(User updatedUser) {
//     _user = updatedUser;
//     notifyListeners();
//   }

//   void clearUser() {
//     _user = null;
//     notifyListeners();
//   }

//   bool get isLoggedIn => _user != null;

//   List<User>? get users => _users;

//   void setUsers(List<User> users) {
//     _users = users;
//     notifyListeners();
//   }

//   void updateUserInList(User updatedUser) {
//     if (_users != null) {
//       int index = _users!.indexWhere((user) => user.userObject == updatedUser.id);
//       if (index != -1) {
//         _users![index] = updatedUser;
//         notifyListeners();
//       }
//     }
//   }

//   void clearUsers() {
//     _users = null;
//     notifyListeners();
//   }

//   bool get hasUsers => _users != null && _users!.isNotEmpty;
// }

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

  List<User>? get users => _users;

  void setUsers(List<User> users) {
    _users = users;
    notifyListeners();
  }

  // Update specific user details
  void updateUser(UserObject updatedUserObject) {
    if (_user != null) {
      _user = User(
        success: _user!.success,
        userObject: updatedUserObject,
        token: _user!.token,
      );
      notifyListeners();
    }
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  bool get isLoggedIn => _user != null;

  void updateNotificationPreferences(NotificationPreferences preferences) {
    if (_user != null) {
      final updatedUserObject = _user!.userObject.copyWith(
        notificationPreferences: preferences,
      );
      updateUser(updatedUserObject);
    }
  }

    void clearUsers() {
    _users = null;
    notifyListeners();
  }
  bool get hasUsers => _users != null && _users!.isNotEmpty;

}
