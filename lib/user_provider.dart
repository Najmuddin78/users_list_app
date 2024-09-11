import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  bool _loading = false;
  bool _error = false;

  List<User> get users => _users;
  bool get loading => _loading;
  bool get error => _error;

  Future<void> fetchUsers() async {
    _loading = true;
    _error = false;
    notifyListeners();

    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _users = data.map((userJson) => User.fromJson(userJson)).toList();
      } else {
        _error = true;
      }
    } catch (e) {
      _error = true;
    }

    _loading = false;
    notifyListeners();
  }
}
