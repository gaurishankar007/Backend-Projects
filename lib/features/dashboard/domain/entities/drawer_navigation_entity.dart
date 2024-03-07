import 'package:flutter/material.dart' show IconData;

class DrawerNavigationEntity {
  final int id;
  final String name;
  final IconData iconData;

  const DrawerNavigationEntity({
    required this.id,
    required this.name,
    required this.iconData,
  });
}
