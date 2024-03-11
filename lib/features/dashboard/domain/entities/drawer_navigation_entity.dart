import 'package:flutter/material.dart' show IconData;

class NavigationDataEntity {
  final int id;
  final String name;
  final IconData iconData;

  const NavigationDataEntity({
    required this.id,
    required this.name,
    required this.iconData,
  });
}
