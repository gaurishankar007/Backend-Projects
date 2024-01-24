part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  ThemeState get toggle => themeMode == ThemeMode.light ? ThemeState.dark() : ThemeState.light();
  factory ThemeState.light() => const ThemeState(ThemeMode.light);
  factory ThemeState.dark() => const ThemeState(ThemeMode.dark);

  @override
  List<Object?> get props => [themeMode];
}
