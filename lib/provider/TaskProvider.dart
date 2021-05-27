import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider with ChangeNotifier{
  
  SharedPreferences _prefs;  
  SharedPreferences get getPreference => _prefs;
  Future<SharedPreferences> initPreference() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }
  bool _showUpdate = true;

  bool get showUpdate => _showUpdate;

  void setShowUpdate(bool showUpdate) {
    _showUpdate = showUpdate;
    notifyListeners();
  }
  
}