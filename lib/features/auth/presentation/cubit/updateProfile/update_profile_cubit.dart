import '../../../domain/useCases/save_user_data_use_case.dart';
import '../../../domain/useCases/update_profile_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/services/user_service.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();
  String imagePath = "";

  final UpdateProfileUseCase updateProfileUseCase;
  final SaveUserDataUseCase saveUserDataUseCase;
  final UserService userService;

  UpdateProfileCubit({
    required this.updateProfileUseCase,
    required this.saveUserDataUseCase,
    required this.userService,
  }) : super(UpdateProfileState.initial());

  selectImage(String path) {
    imagePath = path;
    emit(state.copyWith(error: "", imagePath: path));
  }

  Future<bool> updateProfile() async {
    if (imagePath.isEmpty) {
      emit(state.copyWith(error: "Select a image"));
      return false;
    }

    emit(state.copyWith(error: ""));

    final dataState = await updateProfileUseCase.call(imagePath);
    if (dataState is! DataSuccess) {
      emit(state.copyWith(error: dataState.error!.message));
      return false;
    }

    userService.userData = userService.userData.copyWith(user: dataState.data!);
    saveUserDataUseCase.call(userService.userData);
    return true;
  }
}
