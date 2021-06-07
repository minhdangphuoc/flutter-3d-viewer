import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;

  NavigationModel({required this.title, required this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "spaceship.obj", icon: Icons.view_in_ar),
  NavigationModel(title: "space.obj", icon: Icons.view_in_ar),
];
