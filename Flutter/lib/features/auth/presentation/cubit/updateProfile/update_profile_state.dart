part of 'update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  final String imagePath;
  final String error;

  const UpdateProfileState({
    required this.imagePath,
    required this.error,
  });

  factory UpdateProfileState.initial() => const UpdateProfileState(
        imagePath: "",
        error: "",
      );

  UpdateProfileState copyWith({
    String? imagePath,
    String? error,
  }) =>
      UpdateProfileState(
        imagePath: imagePath ?? this.imagePath,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [
        imagePath,
        error,
      ];
}
