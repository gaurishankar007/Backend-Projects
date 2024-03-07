part of 'setting_cubit.dart';

@freezed
class SettingState extends Equatable {
  final bool refresh;
  final List<SettingNavigationModel> navigationModels;

  const SettingState({
    required this.refresh,
    required this.navigationModels,
  });

  factory SettingState.initial(List<SettingNavigationModel> navigationItems) =>
      SettingState(refresh: false, navigationModels: navigationItems);

  @override
  List<Object?> get props => [
        refresh,
        navigationModels,
      ];
}
