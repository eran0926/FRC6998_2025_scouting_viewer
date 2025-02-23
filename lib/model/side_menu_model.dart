import 'package:flutter/material.dart';

class SideMenuModel {
  final String title;
  final String route;
  final Widget page;

  const SideMenuModel(
      {required this.title, required this.route, required this.page});
}
