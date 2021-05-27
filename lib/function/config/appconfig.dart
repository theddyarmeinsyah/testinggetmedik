import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppConfig extends InheritedWidget {
  AppConfig({
    @required this.appName,
    @required this.envName,
    @required this.apiBaseUrl,
    @required Widget child,
  }) : super(child: child);

  final String appName;
  final String envName;
  final String apiBaseUrl;

  static AppConfig of(BuildContext context) {
    // ignore: deprecated_member_use
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}