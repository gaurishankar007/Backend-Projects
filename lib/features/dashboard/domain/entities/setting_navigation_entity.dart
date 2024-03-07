import 'package:flutter/material.dart' show IconData, Color;

class SettingNavigationEntity {
  final int id;
  final IconData iconData;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final String value;
  final String routePath;

  const SettingNavigationEntity({
    required this.id,
    required this.iconData,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.routePath,
  });
}
