import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection/injector.dart';
import '../../../data/models/settingNavigation/setting_navigation_model.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  bool _refresh = false;
  SettingCubit() : super(SettingState.initial(userService.navigationModels));

  changeSetting(SettingNavigationModel newModel) {
    userService.changeSetting(newModel);

    _refresh = !_refresh;
    emit(SettingState(refresh: _refresh, navigationModels: userService.navigationModels));
  }
}
