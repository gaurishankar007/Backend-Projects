import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../injection/injector.dart';
import '../../../../auth/injection/auth_injector.dart';
import '../../../data/models/settingNavigation/setting_navigation_model.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  bool _refresh = false;
  final List<SettingNavigationModel> _navigationModels = userService.navigationModels.toList();
  SettingCubit() : super(SettingState.initial(userService.navigationModels));

  _updateState() {
    _refresh = !_refresh;
    emit(SettingState(refresh: _refresh, navigationModels: _navigationModels));
  }

  changeSetting(SettingNavigationModel newModel) {
    /// Finding Index of the old model
    final index = _navigationModels.indexWhere((element) => element.id == newModel.id);
    if (index == -1) return;

    /// Updating data
    _navigationModels[index] = newModel;
    _updateState();

    /// Saving new setting
    saveUserSettingUseCase.call(newModel);
  }
}
