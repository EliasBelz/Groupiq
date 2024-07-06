import 'package:flutter/material.dart';
import 'package:groupiq_flutter/models/user.dart';

class CurrentUserProvider extends ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;

  setUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }
}
