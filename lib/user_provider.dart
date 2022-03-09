import 'package:deneme1/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:deneme1/user.dart';

class UserProvider with ChangeNotifier{

  late User _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser {
    return _user;
  }

  Future<void> refreshUser() async{

    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}