import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sm_home_nbcha/models/user_model.dart';

class Users with ChangeNotifier {
  User _item = User(
      id: '2',
      fname: 'dev_1',
      lname: 'development',
      token:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZm5hbWUiOiJkZXZfMSIsImxuYW1lIjoiRGV2ZWxvcG1lbnQiLCJqdGkiOiI0bnJMY2xaSjZDIiwiaWF0IjoxNjIyNzM0NTM5LCJleHAiOjE2MjI4MjA5Mzl9.SL3k0vknLY5D5sOpnq5xQfTucYaeUj4qebM9EWP7zAw');

  User get item {
    return _item;
  }

  addUser(User user) {
    _item = user;
    notifyListeners();
  }
}
