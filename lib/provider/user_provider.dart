import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';

class UserProvider with ChangeNotifier
{
  User? _user;
  final AuthMethods _authMethods =AuthMethods();

  User get getUser => _user!;
  Future<void> refresherUser() async {
    User user = await _authMethods.getUserDetail();
    _user=user;
  }
}