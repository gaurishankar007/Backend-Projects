import 'package:flutter/material.dart' show IconData, Color;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/setting_navigation_entity.dart';

part "setting_navigation_model.freezed.dart";

@freezed
class SettingNavigationModel extends SettingNavigationEntity with _$SettingNavigationModel {
  const factory SettingNavigationModel({
    required int id,
    required IconData iconData,
    required Color backgroundColor,
    required String title,
    required String subtitle,
    required String value,
    required String routePath,
  }) = _SettingNavigationModel;
}
