part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  factory ThemeState.light() => const ThemeState(ThemeMode.light);
  factory ThemeState.dark() => const ThemeState(ThemeMode.dark);

  @override
  List<Object?> get props => [themeMode];
}
