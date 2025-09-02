import 'package:flutter/material.dart' show IconData, Color;

class SettingNavigator {
  final int id;
  final IconData iconData;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final String value;
  final String routePath;

  const SettingNavigator({
    required this.id,
    required this.iconData,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.routePath,
  });

  SettingNavigator copyWith({
    int? id,
    IconData? iconData,
    Color? backgroundColor,
    String? title,
    String? subtitle,
    String? value,
    String? routePath,
  }) =>
      SettingNavigator(
        id: id ?? this.id,
        iconData: iconData ?? this.iconData,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        value: value ?? this.value,
        routePath: routePath ?? this.routePath,
      );
}
